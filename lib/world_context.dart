import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'constants.dart';
import 'functions.dart';
import 'src/json/messages/custom_message.dart';
import 'src/json/messages/custom_sound.dart';
import 'src/json/sound.dart';
import 'src/json/world.dart';
import 'src/level/credits_menu.dart';
import 'src/level/main_menu.dart';
import 'src/level/pause_menu.dart';
import 'src/level/zone_level.dart';
import 'util.dart';

/// A class for running [World] instances.
class WorldContext {
  /// Create an instance.
  const WorldContext({
    required this.game,
    required this.world,
    this.mainMenuBuilder = getMainMenu,
    this.pauseMenuBuilder = getPauseMenu,
    this.creditsMenuBuilder = getCreditsMenu,
    this.zoneMenuBuilder = getZoneLevel,
    this.onEdgeOfZoneLevel,
  });

  /// The game to use.
  final Game game;

  /// The world to use.
  final World world;

  /// The function that will be used to get the main menu.
  final MenuBuilder<MainMenu> mainMenuBuilder;

  /// The ambiances for the main menu.
  List<Ambiance> get mainMenuAmbiances {
    final music = world.mainMenuMusic;
    return [if (music != null) music];
  }

  /// The function that will get the pause menu.
  final ZoneMenuBuilder<PauseMenu> pauseMenuBuilder;

  /// Get the ambiances for the pause menu.
  List<Ambiance> get pauseMenuAmbiances {
    final music = world.pauseMenuMusic;
    return [if (music != null) music];
  }

  /// The function that will get the credits menu.
  final MenuBuilder<CreditsMenu> creditsMenuBuilder;

  /// The ambiances for the credits menu.
  List<Ambiance> get creditsMenuAmbiances {
    final music = world.creditsMenuMusic;
    return [if (music != null) music];
  }

  /// The function that will be called to get a zone level.
  final ZoneMenuBuilder<ZoneLevel> zoneMenuBuilder;

  /// A function to be called when hitting the edge of a [ZoneLevel].
  final EventCallback<ZoneLevel>? onEdgeOfZoneLevel;

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

  /// Convert the given [message].
  Message getCustomMessage(
    CustomMessage message, {
    Map<String, String> replacements = const {},
    bool keepAlive = false,
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
      final AssetStore assetStore;
      switch (sound.assetStore) {
        case CustomSoundAssetStore.credits:
          assetStore = world.creditsAssetStore;
          break;
        case CustomSoundAssetStore.equipment:
          assetStore = world.equipmentAssetStore;
          break;
        case CustomSoundAssetStore.interface:
          assetStore = world.interfaceSoundsAssetStore;
          break;
        case CustomSoundAssetStore.music:
          assetStore = world.musicAssetStore;
          break;
        case CustomSoundAssetStore.terrain:
          assetStore = world.terrainAssetStore;
          break;
      }
      assetReference = getAssetReferenceReference(
        assets: assetStore.assets,
        id: sound.id,
      )!
          .reference;
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
}
