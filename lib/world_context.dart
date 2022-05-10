import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:encrypt/encrypt.dart';
import 'package:open_url/open_url.dart';
import 'package:path/path.dart' as path;
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'constants.dart';
import 'util.dart';
import 'worldsmith.dart';

/// A class for running [World] instances.
class WorldContext {
  /// Create an instance.
  WorldContext({
    required this.sdl,
    required this.game,
    required this.world,
    this.customCommands = const {},
    this.conditionalFunctions = const {},
    this.errorHandler,
  })  : hapticDevices = [],
        preferencesDirectory = sdl.getPrefPath(
          world.globalOptions.orgName,
          world.globalOptions.appName,
        ),
        _audioBusses = {},
        _reverbs = {};

  /// Return an instance with its [world] loaded from an encrypted file.
  factory WorldContext.loadEncrypted({
    required final String encryptionKey,
    final String filename = encryptedWorldFilename,
    final Game? game,
    final CustomCommandsMap customCommands = const {},
    final ErrorHandler? errorHandler,
  }) {
    final sdl = Sdl();
    final world = World.loadEncrypted(
      encryptionKey: encryptionKey,
      filename: filename,
    );
    return WorldContext(
      sdl: sdl,
      game: game ??
          Game(
            'Worldsmith Game',
            triggerMap: world.triggerMap,
          ),
      world: world,
      customCommands: customCommands,
      errorHandler: errorHandler,
    );
  }

  /// The SDL instance to use.
  ///
  /// The [Sdl.init] method will be called by the [run] method.
  final Sdl sdl;

  /// The game to use.
  final Game game;

  /// The world to use.
  final World world;

  /// The map of custom commands.
  ///
  /// These commands are used when the [WorldCommand] class has a custom command
  /// string assigned.
  final CustomCommandsMap customCommands;

  /// The map of custom conditional functions.
  final ConditionalFunctionsMap conditionalFunctions;

  /// The list of initialised haptic devices.
  final List<Haptic> hapticDevices;

  /// The directory where preferences should be stored.
  final String preferencesDirectory;

  /// The file where [playerPreferences] should be saved.
  File get playerPreferencesFile =>
      File(path.join(preferencesDirectory, preferencesFilename));

  /// The file where the trigger map should be stored.
  File get triggerMapFile =>
      File(path.join(preferencesDirectory, triggerMapFilename));

  /// The loaded player preferences.
  PlayerPreferences? _playerPreferences;

  /// Get the current player preferences.
  ///
  /// If none are loaded, then a copy of the [world]'s default preferences will
  /// be created, saved, and returned.
  PlayerPreferences get playerPreferences {
    final currentPreferences = _playerPreferences;
    if (currentPreferences != null) {
      return currentPreferences;
    }
    if (playerPreferencesFile.existsSync()) {
      final data = playerPreferencesFile.readAsStringSync();
      final json = jsonDecode(data) as JsonType;
      final preferences = PlayerPreferences.fromJson(json);
      _playerPreferences = preferences;
      return preferences;
    } else {
      final preferences = PlayerPreferences.fromJson(
        world.defaultPlayerPreferences.toJson(),
      );
      _playerPreferences = preferences;
      savePlayerPreferences();
      return preferences;
    }
  }

  /// Save the current [playerPreferences];
  void savePlayerPreferences() {
    final preferences = playerPreferences;
    final json = preferences.toJson();
    final data = indentedJsonEncoder.convert(json);
    playerPreferencesFile.writeAsStringSync(data);
  }

  /// A function that will handle errors from [WorldCommand] instances.
  final ErrorHandler? errorHandler;

  /// The current player statistics.
  Statistics get playerStats => Statistics(
        defaultStats: world.defaultPlayerStats,
        currentStats: playerPreferences.stats,
      );

  /// The created reverbs.
  final Map<String, CreateReverb> _reverbs;

  /// Get the reverb with the given [preset].
  CreateReverb getReverb(final ReverbPresetReference preset) {
    final reverb = _reverbs[preset.id];
    if (reverb != null) {
      return reverb;
    }
    final r = game.createReverb(preset.reverbPreset);
    _reverbs[preset.id] = r;
    return r;
  }

  /// The cached audio busses.
  final Map<String, SoundChannel> _audioBusses;

  /// Get a sound channel that represents the given [audioBus].
  SoundChannel getAudioBus(final AudioBus audioBus) {
    final channel = _audioBusses[audioBus.id];
    if (channel != null) {
      return channel;
    }
    final reverbId = audioBus.reverbId;
    final soundChannel = game.createSoundChannel(
      gain: audioBus.gain ?? world.soundOptions.defaultGain,
      position: audioBus.position,
      reverb: reverbId == null
          ? null
          : getReverb(world.getReverbPresetReference(reverbId)),
    );
    _audioBusses[audioBus.id] = soundChannel;
    return soundChannel;
  }

  /// A function that will be called when hitting the edge of a [ZoneLevel].
  void onEdgeOfZoneLevel(
    final ZoneLevel zoneLevel,
    final Point<double> coordinates,
  ) {}

  /// Get a message suitable for a [MenuItem] label.
  Message getMenuItemMessage({
    final String? text,
    final Sound? sound,
  }) =>
      Message(
        gain: sound?.gain ??
            world.soundOptions.menuMoveSound?.gain ??
            world.soundOptions.defaultGain,
        keepAlive: true,
        sound: sound == null
            ? world.menuMoveSound
            : getAssetReferenceReference(
                assets: world.interfaceSoundsAssets,
                id: sound.id,
              ).reference,
        text: text,
      );

  /// Get a message with the given [sound].
  Message getSoundMessage({
    required final Sound sound,
    required final AssetList assets,
    required final String? text,
    final bool keepAlive = false,
  }) =>
      Message(
        gain: sound.gain,
        keepAlive: keepAlive,
        sound: getAssetReferenceReference(
          assets: assets,
          id: sound.id,
        ).reference,
        text: text,
      );

  /// Get the asset store for the given [customSoundAssetStore].
  AssetStore getAssetStore(final CustomSoundAssetStore customSoundAssetStore) {
    switch (customSoundAssetStore) {
      case CustomSoundAssetStore.ambiances:
        return world.ambianceAssetStore;
      case CustomSoundAssetStore.conversations:
        return world.conversationAssetStore;
      case CustomSoundAssetStore.credits:
        return world.creditsAssetStore;
      case CustomSoundAssetStore.equipment:
        return world.equipmentAssetStore;
      case CustomSoundAssetStore.interface:
        return world.interfaceSoundsAssetStore;
      case CustomSoundAssetStore.music:
        return world.musicAssetStore;
      case CustomSoundAssetStore.quest:
        return world.questsAssetStore;
      case CustomSoundAssetStore.terrain:
        return world.terrainAssetStore;
    }
  }

  /// Get the sound from the given [sound].
  AssetReference getCustomSound(final CustomSound sound) =>
      getAssetReferenceReference(
        assets: getAssetStore(sound.assetStore).assets,
        id: sound.id,
      ).reference;

  /// Get a button with the proper activate sound.
  Button getButton(final TaskFunction func) =>
      Button(func, activateSound: world.menuActivateSound);

  /// Get a message with the given parameters.
  Message getCustomMessage({
    final String? message,
    final Map<String, String> replacements = const {},
    final AssetReference? sound,
    final double? gain,
    final bool keepAlive = false,
  }) {
    var text = message;
    if (text != null) {
      for (final entry in replacements.entries) {
        text = text?.replaceAll('{${entry.key}}', entry.value);
      }
    }
    return Message(
      gain: gain ?? world.soundOptions.defaultGain,
      keepAlive: keepAlive,
      sound: sound,
      text: text,
    );
  }

  /// Output the given [message].
  PlaySound? outputCustomMessage(
    final String? message, {
    final Map<String, String> replacements = const {},
    final AssetReference? sound,
    final double? gain,
    final bool keepAlive = false,
    final PlaySound? oldSound,
    final SoundChannel? soundChannel,
  }) =>
      game.outputMessage(
        getCustomMessage(
          gain: gain,
          keepAlive: keepAlive,
          message: message,
          replacements: replacements,
          sound: sound,
        ),
        oldSound: oldSound,
        soundChannel: soundChannel ?? game.interfaceSounds,
      );

  /// Get the main menu for the given [WorldContext].
  MainMenu getMainMenu() => MainMenu(this);

  /// Returns a menu that will show credits.
  CreditsMenu getCreditsMenu() => CreditsMenu(this);

  /// Returns a menu that will show game controls.
  ControlsMenu getControlsMenu() => ControlsMenu(worldContext: this);

  /// Returns a menu that will allow the configuration of sound options.
  SoundOptionsMenu getSoundOptionsMenu() => SoundOptionsMenu(this);

  /// Return a zone level.
  ZoneLevel getZoneLevel(final Zone zone) =>
      ZoneLevel(worldContext: this, zone: zone);

  /// Returns the pause menu.
  PauseMenu getPauseMenu(final Zone zone) => PauseMenu(this, zone);

  /// Get the quests menu.
  QuestMenu getQuestMenu() => QuestMenu(worldContext: this);

  /// Get a level for the given [scene].
  SceneLevel getSceneLevel({
    required final Scene scene,
    final CallCommand? callCommand,
  }) =>
      SceneLevel(
        worldContext: this,
        scene: scene,
        callCommand: callCommand,
      );

  /// Get a suitable level for the given [conversation].
  ConversationLevel getConversationLevel({
    required final Conversation conversation,
    required final int pushInitialBranchAfter,
    final int? fadeTime,
  }) =>
      ConversationLevel(
        worldContext: this,
        pushInitialBranchAfter: pushInitialBranchAfter,
        conversation: conversation,
        fadeTime: fadeTime,
      );

  /// Get a custom menu level.
  CustomMenuLevel getCustomMenuLevel(final CustomMenu menu) =>
      CustomMenuLevel(worldContext: this, customMenu: menu);

  /// Returns the given [world] as a JSON string.
  String getWorldJsonString({final bool compact = true}) {
    final json = world.toJson();
    if (compact) {
      return jsonEncode(json);
    }
    return indentedJsonEncoder.convert(json);
  }

  /// Save the given [world] with a random encryption key.
  ///
  /// The encryption key will be returned.
  String saveEncrypted({final String filename = encryptedWorldFilename}) {
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
  Future<void> run({final EventCallback<SoundEvent>? onSound}) async {
    Synthizer? synthizer;
    Context? context;
    if (triggerMapFile.existsSync() == true) {
      final data = triggerMapFile.readAsStringSync();
      final json = jsonDecode(data) as JsonType;
      final triggerMap = TriggerMap.fromJson(json);
      for (final trigger in triggerMap.triggers) {
        game.triggerMap.triggers.removeWhere(
          (final element) => element.name == trigger.name,
        );
      }
      game.triggerMap.triggers.addAll(triggerMap.triggers);
    }
    final preferences = playerPreferences;
    if (onSound == null) {
      final soundOptions = world.soundOptions;
      String? libsndfilePath;
      if (Platform.isLinux) {
        libsndfilePath = soundOptions.libsndfilePathLinux;
      } else if (Platform.isWindows) {
        libsndfilePath = soundOptions.libsndfilePathWindows;
      } else if (Platform.isMacOS) {
        libsndfilePath = soundOptions.libsndfilePathMac;
      }
      if (libsndfilePath == null ||
          File(libsndfilePath).existsSync() == false) {
        libsndfilePath = null;
      }
      synthizer = Synthizer()
        ..initialize(
          logLevel: soundOptions.synthizerLogLevel,
          loggingBackend: soundOptions.synthizerLoggingBackend,
          libsndfilePath: libsndfilePath,
        );
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
      game.sounds.listen(soundManager.handleEvent);
    } else {
      game.sounds.listen(onSound);
    }
    sdl.init();
    try {
      await game.run(
        sdl,
        framesPerSecond: world.globalOptions.framesPerSecond,
        onStart: () {
          game
            ..interfaceSounds.gain = preferences.interfaceSoundsGain
            ..musicSounds.gain = preferences.musicGain
            ..ambianceSounds.gain = preferences.musicGain
            ..setDefaultPannerStrategy(preferences.pannerStrategy)
            ..pushLevel(
              getMainMenu(),
            );
        },
      );
      final json = game.triggerMap.toJson();
      final data = indentedJsonEncoder.convert(json);
      triggerMapFile.writeAsStringSync(data);
    } on Exception {
      rethrow;
    } finally {
      context?.destroy();
      synthizer?.shutdown();
      sdl.quit();
      for (final haptic in hapticDevices) {
        haptic.close();
      }
    }
  }

  /// Handle a [walkingMode] command.
  void handleWalkingMode({
    required final WalkingMode walkingMode,
    required final ZoneLevel zoneLevel,
  }) {
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

  /// Handle a [zoneTeleport] command.
  void handleZoneTeleport({
    required final ZoneTeleport zoneTeleport,
  }) {
    final zone = world.getZone(zoneTeleport.zoneId);
    final coordinates = zoneTeleport.getCoordinates(
      zone: zone,
      random: game.random,
    );
    final level = getZoneLevel(zone)
      ..coordinates = coordinates.toDouble()
      ..heading = zoneTeleport.heading.toDouble();
    game.replaceLevel(level, ambianceFadeTime: zoneTeleport.fadeTime);
  }

  /// Handle the custom command with the given [name].
  void handleCustomCommandName(final String name) {
    try {
      final f = customCommands[name];
      if (f == null) {
        throw UnimplementedError(
          'There is no command named $name.',
        );
      }
      f(this);
    } on Exception catch (e, s) {
      final f = errorHandler;
      if (f != null) {
        f(e, s);
      } else {
        rethrow;
      }
    }
  }

  /// Handle a [startConversation] command.
  void handleStartConversation(final StartConversation startConversation) {
    final conversation = world.getConversation(
      startConversation.conversationId,
    );
    final level = getConversationLevel(
      conversation: conversation,
      pushInitialBranchAfter: startConversation.pushInitialBranchAfter,
      fadeTime: startConversation.fadeTime,
    );
    if (game.currentLevel is MainMenu) {
      game.replaceLevel(
        level,
        ambianceFadeTime: world.mainMenuOptions.fadeTime,
      );
    } else {
      game.pushLevel(level);
    }
  }

  /// Handle a [setQuestStage] instance.
  void handleSetQuestStage(final SetQuestStage setQuestStage) {
    final stageId = setQuestStage.stageId;
    if (stageId == null) {
      playerPreferences.questStages.remove(setQuestStage.questId);
    } else {
      playerPreferences.questStages[setQuestStage.questId] = stageId;
    }
    savePlayerPreferences();
  }

  /// Handle the given [questCondition].
  bool handleQuestCondition(final QuestCondition questCondition) =>
      playerPreferences.questStages[questCondition.questId] ==
      questCondition.stageId;

  /// Handle the given [statCondition] for the player.
  bool handleStatCondition(final StatCondition statCondition) => true;

  /// Handle a conditional function with the given [name].
  ///
  /// The default implementation returns `false` if the function fails, and
  /// [errorHandler] is not `null`.
  bool handleConditionalFunction(final String name) {
    final f = conditionalFunctions[name];
    if (f == null) {
      throw UnimplementedError('There is no conditional function named $name.');
    }
    try {
      return f(this);
    } on Exception catch (e, s) {
      final f = errorHandler;
      if (f != null) {
        f(e, s);
        return false;
      }
      rethrow;
    }
  }

  /// Handle the given [conditional].
  bool handleConditional(final Conditional conditional) {
    final questCondition = conditional.questCondition;
    if (questCondition != null) {
      if (handleQuestCondition(questCondition) == false) {
        return false;
      }
    }
    final conditionFunctionName = conditional.conditionFunctionName;
    if (conditionFunctionName != null) {
      if (handleConditionalFunction(conditionFunctionName) == false) {
        return false;
      }
    }
    return conditional.chance == 1 ||
        game.random.nextInt(conditional.chance) == 0;
  }

  /// Handle a list of [conditionals].
  bool handleConditionals(final Iterable<Conditional> conditionals) {
    for (final conditional in conditionals) {
      if (handleConditional(conditional) == false) {
        return false;
      }
    }
    return true;
  }

  /// Return to the main menu.
  void handleReturnToMainMenu(final ReturnToMainMenu returnToMainMenu) {
    final fadeTime = returnToMainMenu.fadeTime;
    while (game.currentLevel != null) {
      game.popLevel(ambianceFadeTime: fadeTime);
    }
    if (returnToMainMenu.savePlayerPreferences) {
      savePlayerPreferences();
    }
    game.pushLevel(getMainMenu());
  }

  /// Handle a show scene event.
  void handleShowScene(final ShowScene showScene) {
    final scene = world.getScene(showScene.sceneId);
    final level = getSceneLevel(
      scene: scene,
      callCommand: showScene.callCommand,
    );
    if (game.currentLevel is MainMenu) {
      game.replaceLevel(
        level,
        ambianceFadeTime: world.mainMenuOptions.fadeTime,
      );
    } else {
      game.pushLevel(level);
    }
  }

  /// Handle playing a rumble effect.
  void handlePlayRumble(final PlayRumble playRumble) {
    for (final joystick in game.joysticks.values) {
      joystick.rumble(
        duration: playRumble.duration,
        lowFrequency: playRumble.leftFrequency,
        highFrequency: playRumble.rightFrequency,
      );
    }
  }

  /// Handle opening a URL.
  void handleUrl(final String url) {
    game.outputText('Opening $url...');
    openUrl(url);
  }

  /// Handle the showing of a custom [menu].
  void handleCustomMenu(final CustomMenu menu) =>
      game.pushLevel(getCustomMenuLevel(menu));

  /// Run the given [command].
  ///
  /// All of [nullSound], [soundChannel], and [replacements] will be passed to
  /// [outputCustomMessage].
  void runCommand({
    required final WorldCommand command,
    final Map<String, String> replacements = const {},
    final ZoneLevel? zoneLevel,
    final SoundChannel? soundChannel,
    final AssetReference? nullSound,
    final List<CallCommand> calledCommands = const [],
  }) {
    final sound = command.sound;
    final audioBusId = sound?.audioBusId;
    final soundChannel = audioBusId == null
        ? game.interfaceSounds
        : getAudioBus(
            world.getAudioBus(
              audioBusId,
            ),
          );
    final gain = sound?.gain ?? world.soundOptions.defaultGain;
    final asset = sound == null ? null : getCustomSound(sound);
    outputCustomMessage(
      command.text,
      replacements: replacements,
      gain: gain,
      sound: asset,
      soundChannel: soundChannel,
    );
    if (zoneLevel != null) {
      final walkingMode = command.walkingMode;
      if (walkingMode != null) {
        handleWalkingMode(
          walkingMode: walkingMode,
          zoneLevel: zoneLevel,
        );
      }
    }
    final zoneTeleport = command.zoneTeleport;
    if (zoneTeleport != null) {
      handleZoneTeleport(zoneTeleport: zoneTeleport);
    }
    final customCommandName = command.customCommandName;
    if (customCommandName != null) {
      handleCustomCommandName(customCommandName);
    }
    final callCommands = command.callCommands;
    handleCallCommands(
      callCommands: callCommands,
      calledCommands: calledCommands,
      nullSound: nullSound,
      replacements: replacements,
      soundChannel: soundChannel,
      zoneLevel: zoneLevel,
    );
    final startConversation = command.startConversation;
    if (startConversation != null) {
      handleStartConversation(startConversation);
    }
    final setQuestStage = command.setQuestStage;
    if (setQuestStage != null) {
      handleSetQuestStage(setQuestStage);
    }
    final returnToMainMenu = command.returnToMainMenu;
    if (returnToMainMenu != null) {
      handleReturnToMainMenu(returnToMainMenu);
    }
    final showScene = command.showScene;
    if (showScene != null) {
      handleShowScene(showScene);
    }
    final playRumble = command.playRumble;
    if (playRumble != null) {
      handlePlayRumble(playRumble);
    }
    final url = command.url;
    if (url != null) {
      handleUrl(url);
    }
    final customMenuId = command.customMenuId;
    if (customMenuId != null) {
      handleCustomMenu(world.getMenu(customMenuId));
    }
  }

  /// Handle a list of [callCommands].
  void handleCallCommands({
    required final List<CallCommand> callCommands,
    final List<CallCommand> calledCommands = const [],
    final Map<String, String> replacements = const {},
    final AssetReference? nullSound,
    final SoundChannel? soundChannel,
    final ZoneLevel? zoneLevel,
  }) {
    for (final callCommand in callCommands) {
      handleCallCommand(
        callCommand: callCommand,
        calledCommands: calledCommands,
        nullSound: nullSound,
        replacements: replacements,
        soundChannel: soundChannel,
        zoneLevel: zoneLevel,
      );
    }
  }

  /// Call the specified [callCommand].
  void handleCallCommand({
    required final CallCommand callCommand,
    final List<CallCommand> calledCommands = const [],
    final Map<String, String> replacements = const {},
    final AssetReference? nullSound,
    final SoundChannel? soundChannel,
    final ZoneLevel? zoneLevel,
  }) {
    if (calledCommands.contains(callCommand)) {
      final category = world.commandCategories.firstWhere(
        (final element) => element.commands
            .where(
              (final element) => element.id == callCommand.commandId,
            )
            .isNotEmpty,
      );
      final commandName = category.commands.firstWhere(
        (final element) => element.id == callCommand.commandId,
      );
      throw UnsupportedError(
        'The $commandName command from the ${category.name} is attempting '
        'to call itself.',
      );
    }
    if (handleConditionals(callCommand.conditions) == false) {
      return;
    }
    final command = world.getCommand(callCommand.commandId);
    final callAfter = callCommand.callAfter;
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

  /// Handle the given [customSound].
  void handleCustomSound(final CustomSound customSound) {
    final assetReference = getCustomSound(customSound);
    final audioBusId = customSound.audioBusId;
    final SoundChannel channel;
    if (audioBusId == null) {
      channel = game.interfaceSounds;
    } else {
      channel = getAudioBus(world.getAudioBus(audioBusId));
    }
    channel.playSound(
      assetReference,
      gain: customSound.gain,
    );
  }

  /// Get the name of the nearest direction to [bearing].
  String getDirectionName(final int bearing) {
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
    final String? id, {
    final Map<String, String> replacements = const {},
    final AssetReference? nullSound,
    final SoundChannel? soundChannel,
    final ZoneLevel? zoneLevel,
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

  /// Increase the gain on the given [soundChannel] by [value].
  void changeSoundChannelGain({
    required final SoundChannel soundChannel,
    required final double value,
  }) {
    var gain = soundChannel.gain + value;
    if (gain < 0) {
      gain = 0.0;
    }
    if (gain > 1) {
      gain = 1;
    }
    soundChannel.gain = gain;
    final sound = world.menuActivateSound;
    if (sound != null) {
      soundChannel.playSound(sound);
    }
    if (soundChannel == game.interfaceSounds) {
      playerPreferences.interfaceSoundsGain = gain;
    } else if (soundChannel == game.musicSounds) {
      playerPreferences.musicGain = gain;
    } else if (soundChannel == game.ambianceSounds) {
      playerPreferences.ambianceGain = gain;
    } else {
      return;
    }
    savePlayerPreferences();
  }

  /// Get a valid parameter for the given [soundChannel] and [title].
  ParameterMenuParameter getGainParameter({
    required final String title,
    required final SoundChannel soundChannel,
  }) =>
      ParameterMenuParameter(
        getLabel: () {
          final gain = soundChannel.gain.toStringAsFixed(1);
          return Message(
            gain: world.soundOptions.defaultGain,
            keepAlive: true,
            sound: world.menuMoveSound,
            text: '$title $gain',
          );
        },
        increaseValue: () => changeSoundChannelGain(
          soundChannel: soundChannel,
          value: world.soundMenuOptions.gainAdjust,
        ),
        decreaseValue: () => changeSoundChannelGain(
          soundChannel: soundChannel,
          value: -world.soundMenuOptions.gainAdjust,
        ),
      );

  /// Play the menu cancel sound, if it is set.
  void playMenuCancelSound() {
    final sound = world.soundOptions.menuCancelSound;
    if (sound != null) {
      playSound(
        channel: game.interfaceSounds,
        sound: sound,
        assets: world.interfaceSoundsAssets,
      );
    }
  }

  /// Play the menu switch sound.
  void playMenuSwitchSound() {
    final sound = world.soundOptions.menuSwitchSound;
    if (sound != null) {
      playSound(
        channel: game.interfaceSounds,
        sound: sound,
        assets: world.interfaceSoundsAssets,
      );
    }
  }
}
