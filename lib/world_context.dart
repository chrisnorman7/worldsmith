import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:encrypt/encrypt.dart';
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'command_triggers.dart';
import 'constants.dart';
import 'src/json/commands/call_command.dart';
import 'src/json/commands/world_command.dart';
import 'src/json/messages/custom_message.dart';
import 'src/json/messages/custom_sound.dart';
import 'src/json/sound.dart';
import 'src/json/world.dart';
import 'src/json/zones/zone.dart';
import 'src/level/credits_menu.dart';
import 'src/level/main_menu.dart';
import 'src/level/pause_menu.dart';
import 'src/level/walking_mode.dart';
import 'src/level/zone_level.dart';
import 'util.dart';

/// A class for running [World] instances.
class WorldContext {
  /// Create an instance.
  const WorldContext({
    required this.game,
    required this.world,
    this.customCommands = const {},
    this.errorHandler,
  });

  /// Return an instance with its [world] loaded from an encrypted file.
  WorldContext.loadEncrypted({
    required String encryptionKey,
    String filename = encryptedWorldFilename,
    Game? game,
    this.customCommands = const {},
    this.errorHandler,
  })  : game = game ?? Game('Worldsmith Game', triggerMap: defaultTriggerMap),
        world = World.loadEncrypted(
            encryptionKey: encryptionKey, filename: filename);

  /// The game to use.
  final Game game;

  /// The world to use.
  final World world;

  /// The map of custom commands.
  ///
  /// These commands are used when the [WorldCommand] class has a custom command
  /// string assigned.
  final Map<String, EventCallback<WorldContext>> customCommands;

  /// A function that will handle errors from [WorldCommand] instances.
  final void Function(Object e, StackTrace? s)? errorHandler;

  /// The ambiances for the main menu.
  List<Ambiance> get mainMenuAmbiances {
    final music = world.mainMenuMusic;
    return [if (music != null) music];
  }

  /// Get the ambiances for the pause menu.
  List<Ambiance> get pauseMenuAmbiances {
    final music = world.pauseMenuMusic;
    return [if (music != null) music];
  }

  /// The ambiances for the credits menu.
  List<Ambiance> get creditsMenuAmbiances {
    final music = world.creditsMenuMusic;
    return [if (music != null) music];
  }

  /// A function that will be called when hitting the edge of a [ZoneLevel].
  void onEdgeOfZoneLevel(ZoneLevel zoneLevel, Point<double> coordinates) {}

  /// Get a message suitable for a [MenuItem] label.
  Message getMenuItemMessage({String? text}) => Message(
        gain: world.soundOptions.menuMoveSound?.gain ??
            world.soundOptions.defaultGain,
        keepAlive: true,
        sound: world.menuMoveSound,
        text: text,
      );

  /// Get a message with the given [sound].
  Message getSoundMessage({
    required Sound sound,
    required AssetList assets,
    required String? text,
    bool keepAlive = false,
  }) =>
      Message(
        gain: sound.gain,
        keepAlive: keepAlive,
        sound: getAssetReferenceReference(
          assets: assets,
          id: sound.id,
        )?.reference,
        text: text,
      );

  /// Get the asset store for the given [customSoundAssetStore].
  AssetStore getAssetStore(CustomSoundAssetStore customSoundAssetStore) {
    switch (customSoundAssetStore) {
      case CustomSoundAssetStore.credits:
        return world.creditsAssetStore;
      case CustomSoundAssetStore.equipment:
        return world.equipmentAssetStore;
      case CustomSoundAssetStore.interface:
        return world.interfaceSoundsAssetStore;
      case CustomSoundAssetStore.music:
        return world.musicAssetStore;
      case CustomSoundAssetStore.terrain:
        return world.terrainAssetStore;
    }
  }

  /// Get the sound from the given [sound].
  AssetReference getCustomSound(CustomSound sound) =>
      getAssetReferenceReference(
        assets: getAssetStore(sound.assetStore).assets,
        id: sound.id,
      )!
          .reference;

  /// Convert the given [message].
  Message getCustomMessage(
    CustomMessage message, {
    Map<String, String> replacements = const {},
    bool keepAlive = false,
    AssetReference? nullSound,
  }) {
    var text = message.text;
    if (text != null) {
      for (final entry in replacements.entries) {
        text = text?.replaceAll('{${entry.key}}', entry.value);
      }
    }
    final sound = message.sound;
    AssetReference? assetReference;
    if (sound != null) {
      assetReference = getCustomSound(sound);
    } else if (nullSound != null) {
      assetReference = nullSound;
    }
    final gain = sound?.gain ?? world.soundOptions.defaultGain;
    return Message(
      gain: gain,
      keepAlive: keepAlive,
      sound: assetReference,
      text: text,
    );
  }

  /// Get a button with the proper activate sound.
  Button getButton(TaskFunction func) =>
      Button(func, activateSound: world.menuActivateSound);

  /// Get a button which will call the given [command].
  Button getWorldCommandButton(WorldCommand command) => Button(
        () => runCommand(command: command),
        activateSound: world.menuActivateSound,
      );

  /// Get the main menu for the given [WorldContext].
  MainMenu getMainMenu() => MainMenu(this);

  /// Returns a menu that will show credits.
  CreditsMenu getCreditsMenu() => CreditsMenu(this);

  /// Return a zone level.
  ZoneLevel getZoneLevel(Zone zone) =>
      ZoneLevel(worldContext: this, zone: zone);

  /// Returns the pause menu.
  PauseMenu getPauseMenu(Zone zone) => PauseMenu(this, zone);

  /// Returns the given [world] as a JSON string.
  String getWorldJsonString({bool compact = true}) {
    final json = world.toJson();
    if (compact) {
      return jsonEncode(json);
    }
    return indentedJsonEncoder.convert(json);
  }

  /// Save the given [world] with a random encryption key.
  ///
  /// The encryption key will be returned.
  String saveEncrypted({String filename = encryptedWorldFilename}) {
    final file = File(filename);
    final encryptionKey = SecureRandom(32).base64;
    final key = Key.fromBase64(encryptionKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final data = encrypter
        .encrypt(
          getWorldJsonString(compact: false),
          iv: iv,
        )
        .bytes;
    file.writeAsBytesSync(data);
    return encryptionKey;
  }

  /// Run this world.
  ///
  /// If [sdl] is not `null`, then it should call [Sdl.init] itself.
  Future<void> run({
    Sdl? sdl,
    EventCallback<SoundEvent>? onSound,
  }) async {
    Synthizer? synthizer;
    Context? context;
    if (onSound == null) {
      synthizer = Synthizer()..initialize();
      context = synthizer.createContext();
      final soundManager = SoundManager(
        game: game,
        context: context,
        bufferCache: BufferCache(
          synthizer: synthizer,
          maxSize: pow(1024, 3).floor(),
          random: game.random,
        ),
      );
      onSound = soundManager.handleEvent;
    }
    game.sounds.listen(onSound);
    sdl ??= Sdl()..init();
    try {
      await game.run(
        sdl,
        framesPerSecond: world.globalOptions.framesPerSecond,
        onStart: () => game
          ..setDefaultPannerStrategy(world.soundOptions.defaultPannerStrategy)
          ..pushLevel(
            getMainMenu(),
          ),
      );
    } catch (e) {
      rethrow;
    } finally {
      context?.destroy();
      synthizer?.shutdown();
      sdl.quit();
    }
  }

  /// Run the given [command].
  void runCommand({
    required WorldCommand command,
    Map<String, String> replacements = const {},
    ZoneLevel? zoneLevel,
    SoundChannel? soundChannel,
    AssetReference? nullSound,
    List<CallCommand> calledCommands = const [],
  }) {
    final message = command.message;
    if (message.sound != null || message.text != null) {
      game.outputMessage(
        getCustomMessage(
          message,
          nullSound: nullSound,
          replacements: replacements,
        ),
        soundChannel: soundChannel,
      );
    }
    if (zoneLevel != null) {
      final localTeleport = command.localTeleport;
      if (localTeleport != null) {
        final destination = localTeleport.getCoordinates(
          zone: zoneLevel.zone,
          random: game.random,
        );
        zoneLevel
          ..moveTo(destination: destination.toDouble())
          ..heading = localTeleport.heading;
      }
      final walkingMode = command.walkingMode;
      if (walkingMode != null) {
        switch (walkingMode) {
          case WalkingMode.stationary:
            zoneLevel.currentWalkingOptions = null;
            break;
          case WalkingMode.slow:
            zoneLevel.currentWalkingOptions = zoneLevel.currentTerrain.slowWalk;
            break;
          case WalkingMode.fast:
            zoneLevel.currentWalkingOptions = zoneLevel.currentTerrain.fastWalk;
            break;
        }
      }
    }
    final zoneTeleport = command.zoneTeleport;
    if (zoneTeleport != null) {
      final zone = world.getZone(zoneTeleport.zoneId);
      final coordinates = zoneTeleport.getCoordinates(
        zone: zone,
        random: game.random,
      );
      final level = getZoneLevel(zone)
        ..coordinates = coordinates.toDouble()
        ..heading = zoneTeleport.heading;
      game.replaceLevel(level, ambianceFadeTime: zoneTeleport.fadeTime);
    }
    final customCommandName = command.customCommandName;
    if (customCommandName != null) {
      try {
        final f = customCommands[customCommandName];
        if (f == null) {
          throw UnimplementedError(
            'There is no command named $customCommandName.',
          );
        }
        f(this);
      } catch (e, s) {
        final f = errorHandler;
        if (f != null) {
          f(e, s);
        } else {
          rethrow;
        }
      }
    }
    final callCommand = command.callCommand;
    runCallCommand(
      callCommand: callCommand,
      calledCommands: calledCommands,
      replacements: replacements,
      nullSound: nullSound,
      soundChannel: soundChannel,
      zoneLevel: zoneLevel,
    );
  }

  /// Call the specified [callCommand].
  ///
  /// If [callCommand] is `null`, nothing happens.
  void runCallCommand({
    required CallCommand? callCommand,
    List<CallCommand> calledCommands = const [],
    Map<String, String> replacements = const {},
    AssetReference? nullSound,
    SoundChannel? soundChannel,
    ZoneLevel? zoneLevel,
  }) {
    if (callCommand != null) {
      if (calledCommands.contains(callCommand)) {
        final category = world.commandCategories.firstWhere(
          (element) => element.commands
              .where(
                (element) => element.id == callCommand.commandId,
              )
              .isNotEmpty,
        );
        final commandName = category.commands.firstWhere(
          (element) => element.id == callCommand.commandId,
        );
        throw UnsupportedError(
          'The $commandName command from the ${category.name} is attempting '
          'to call itself.',
        );
      }
      if (callCommand.chance == 1 ||
          game.random.nextInt(callCommand.chance) == 0) {
        final callAfter = callCommand.callAfter;
        final command = world.getCommand(callCommand.commandId);
        if (callAfter == null) {
          runCommand(
            command: command,
            replacements: replacements,
            calledCommands: [...calledCommands, callCommand],
            nullSound: nullSound,
            soundChannel: soundChannel,
            zoneLevel: zoneLevel,
          );
        } else {
          game.callAfter(
            runAfter: callAfter,
            func: () => runCommand(
              command: command,
              replacements: replacements,
              nullSound: nullSound,
              soundChannel: soundChannel,
              zoneLevel: zoneLevel,
            ),
          );
        }
      }
    }
  }

  /// Get the name of the nearest direction to [bearing].
  String getDirectionName(int bearing) {
    String? direction;
    int? difference;
    for (final entry in world.directions.entries) {
      final value = entry.value.floor();
      final d = max<int>(bearing, value) - min<int>(bearing, value);
      if (difference == null || difference > d) {
        difference = d;
        direction = entry.key;
      }
    }
    return direction ?? 'Unknown';
  }

  /// Run the command with the given [id].
  ///
  /// If the id is `null`, nothing happens.
  void runWorldCommandId(
    String? id, {
    Map<String, String> replacements = const {},
    AssetReference? nullSound,
    SoundChannel? soundChannel,
    ZoneLevel? zoneLevel,
  }) {
    if (id != null) {
      final command = world.getCommand(id);
      runCommand(
        command: command,
        replacements: replacements,
        nullSound: nullSound,
        soundChannel: soundChannel,
        zoneLevel: zoneLevel,
      );
    }
  }
}
