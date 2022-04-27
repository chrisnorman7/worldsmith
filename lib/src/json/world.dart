/// Provides the [World] class.
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import '../../constants.dart';
import '../../util.dart';
import 'commands/command_category.dart';
import 'commands/world_command.dart';
import 'conversations/conversation.dart';
import 'conversations/conversation_category.dart';
import 'equipment/equipment_position.dart';
import 'npcs/npc.dart';
import 'options/credits_menu_options.dart';
import 'options/main_menu_options.dart';
import 'options/pause_menu_options.dart';
import 'options/quest_menu_options.dart';
import 'options/sound_menu_options.dart';
import 'options/sound_options.dart';
import 'options/world_options.dart';
import 'player_preferences.dart';
import 'quests/quest.dart';
import 'reverb_preset_reference.dart';
import 'scenes/scene.dart';
import 'sounds/audio_bus.dart';
import 'sounds/custom_sound.dart';
import 'stats/world_stat.dart';
import 'world_credit.dart';
import 'zones/terrain.dart';
import 'zones/zone.dart';

part 'world.g.dart';

/// The type for a list of credits.
typedef CreditsList = List<WorldCredit>;

/// The type for a list of assets.
typedef AssetList = List<AssetReferenceReference>;

/// The type for a map of direction names and degrees.
typedef DirectionsMap = Map<String, double>;

/// The type for a list of equipment positions.
typedef EquipmentPositions = List<EquipmentPosition>;

/// The type for a list of terrains.
typedef TerrainsList = List<Terrain>;

/// The type for a list of zones.
typedef ZonesList = List<Zone>;

/// The type for a list of reverb references.
typedef ReverbsList = List<ReverbPresetReference>;

/// A list of command categories.
typedef CommandCategoryList = List<CommandCategory>;

/// A list of conversation categories.
typedef ConversationCategoryList = List<ConversationCategory>;

/// A list of quests.
typedef QuestList = List<Quest>;

/// A list of scenes.
typedef SceneList = List<Scene>;

/// A list of stats.
typedef StatList = List<WorldStat>;

/// The top-level world object.
///
/// Instances of this class contain all metadata about a particular world.
///
/// ## Asset Stores
///
/// If you want to add more asset stores, this needs to be done in a few places.
///
/// * Add a property of type [AssetList] on the [World] class.
/// * Initialise the value of this property from a nullable [AssetList] to
/// ensure the list is growable.
/// Add a new member in alphabetical order to the [CustomSoundAssetStore]
/// enumeration.
/// *Update the UI of Worldsmith Studio as necessary.
@JsonSerializable()
class World {
  /// Create an instance.
  World({
    this.title = 'Untitled World',
    final WorldOptions? globalOptions,
    final SoundOptions? soundOptions,
    final MainMenuOptions? mainMenuOptions,
    final CreditsList? credits,
    final CreditsMenuOptions? creditsMenuOptions,
    final SoundMenuOptions? soundMenuOptions,
    final AssetList? creditsAssets,
    final AssetList? musicAssets,
    final AssetList? interfaceSoundsAssets,
    final AssetList? equipmentAssets,
    final AssetList? terrainAssets,
    final AssetList? ambianceAssets,
    final AssetList? conversationAssets,
    final AssetList? questAssets,
    final DirectionsMap? directions,
    final EquipmentPositions? equipmentPositions,
    final TerrainsList? terrains,
    final ZonesList? zones,
    final PauseMenuOptions? pauseMenuOptions,
    final ReverbsList? reverbs,
    final CommandCategoryList? commandCategories,
    final PlayerPreferences? defaultPlayerPreferences,
    final ConversationCategoryList? conversationCategories,
    final QuestList? quests,
    final QuestMenuOptions? questMenuOptions,
    final SceneList? scenes,
    final StatList? stats,
    final Map<String, int>? defaultPlayerStats,
    final List<Npc>? npcs,
    final List<AudioBus>? audioBusses,
  })  : globalOptions = globalOptions ?? WorldOptions(),
        soundOptions = soundOptions ?? SoundOptions(),
        mainMenuOptions = mainMenuOptions ?? MainMenuOptions(),
        credits = credits ?? [],
        creditsMenuOptions = creditsMenuOptions ?? CreditsMenuOptions(),
        soundMenuOptions = soundMenuOptions ?? SoundMenuOptions(),
        creditsAssets = creditsAssets ?? [],
        musicAssets = musicAssets ?? [],
        interfaceSoundsAssets = interfaceSoundsAssets ?? [],
        equipmentAssets = equipmentAssets ?? [],
        terrainAssets = terrainAssets ?? [],
        ambianceAssets = ambianceAssets ?? [],
        conversationAssets = conversationAssets ?? [],
        questAssets = questAssets ?? [],
        directions = directions ??
            defaultDirections.map(
              MapEntry.new,
            ),
        equipmentPositions = equipmentPositions ?? [],
        terrains = terrains ?? [],
        zones = zones ?? [],
        pauseMenuOptions = pauseMenuOptions ?? PauseMenuOptions(),
        reverbs = reverbs ?? [],
        commandCategories = commandCategories ?? [],
        defaultPlayerPreferences =
            defaultPlayerPreferences ?? PlayerPreferences(),
        conversationCategories = conversationCategories ?? [],
        quests = quests ?? [],
        questMenuOptions = questMenuOptions ?? QuestMenuOptions(),
        scenes = scenes ?? [],
        stats = stats ?? [],
        defaultPlayerStats = defaultPlayerStats ?? {},
        npcs = npcs ?? [],
        audioBusses = audioBusses ?? [];

  /// Create an instance from a JSON object.
  factory World.fromJson(final Map<String, dynamic> json) =>
      _$WorldFromJson(json);

  /// Load an instance from the provided [string].
  factory World.fromString(final String string) {
    final json = jsonDecode(string) as JsonType;
    return World.fromJson(json);
  }

  /// Return an instance loaded from the given [filename].
  factory World.fromFilename(final String filename) {
    final file = File(filename);
    final data = file.readAsStringSync();
    return World.fromString(data);
  }

  /// Load an instance from an encrypted file.
  ///
  /// The given [encryptionKey] must be the one returned by a function like
  /// [WorldContext.saveEncrypted.]
  ///
  /// If [filename] is not given, then the default [encryptedWorldFilename] is
  /// used.
  factory World.loadEncrypted({
    required final String encryptionKey,
    final String filename = encryptedWorldFilename,
  }) {
    final asset = AssetReference.file(filename, encryptionKey: encryptionKey);
    final bytes = asset.load(Random());
    return World.fromString(String.fromCharCodes(bytes));
  }

  /// The title of the world.
  String title;

  /// The options for this world.
  final WorldOptions globalOptions;

  /// Sound configuration.
  final SoundOptions soundOptions;

  /// Get the menu move sound.
  AssetReference? get menuMoveSound {
    final sound = soundOptions.menuMoveSound;
    if (sound == null) {
      return null;
    }
    return getAssetReferenceReference(
      assets: interfaceSoundsAssets,
      id: sound.id,
    ).reference;
  }

  /// The menu activate sound.
  AssetReference? get menuActivateSound {
    final sound = soundOptions.menuActivateSound;
    if (sound == null) {
      return null;
    }
    return getAssetReferenceReference(
      assets: interfaceSoundsAssets,
      id: sound.id,
    ).reference;
  }

  /// Get the menu cancel sound.
  AssetReference? get menuCancelSound {
    final sound = soundOptions.menuCancelSound;
    if (sound == null) {
      return null;
    }
    return getAssetReferenceReference(
      assets: interfaceSoundsAssets,
      id: sound.id,
    ).reference;
  }

  /// The options for the main menu.
  final MainMenuOptions mainMenuOptions;

  /// The music for the main menu.
  Music? get mainMenuMusic => getMusic(
        assets: musicAssets,
        sound: mainMenuOptions.music,
      );

  /// The credits for this world.
  final CreditsList credits;

  /// The configuration for the credits menu.
  final CreditsMenuOptions creditsMenuOptions;

  /// The music for the credits menu.
  Music? get creditsMenuMusic => getMusic(
        assets: musicAssets,
        sound: creditsMenuOptions.music,
      );

  /// The options for the sound options menu.
  final SoundMenuOptions soundMenuOptions;

  /// The music for the sound options menu.
  Music? get soundMenuMusic => getMusic(
        assets: musicAssets,
        sound: soundMenuOptions.music,
      );

  /// Credit sounds.
  final AssetList creditsAssets;

  /// The asset store for credits.
  AssetStore get creditsAssetStore => getAssetStore(
        name: 'credits',
        assets: creditsAssets,
        comment: 'Credits sounds',
      );

  /// Musical assets.
  final AssetList musicAssets;

  /// The asset store for music.
  AssetStore get musicAssetStore => getAssetStore(
        name: 'music',
        assets: musicAssets,
        comment: 'Musical assets',
      );

  /// Interface sounds.
  final AssetList interfaceSoundsAssets;

  /// The asset store for interface sounds.
  AssetStore get interfaceSoundsAssetStore => getAssetStore(
        name: 'interface',
        assets: interfaceSoundsAssets,
        comment: 'UI sounds',
      );

  /// Clothing and weapon sounds.
  final AssetList equipmentAssets;

  /// The asset store for equipment sounds.
  AssetStore get equipmentAssetStore => getAssetStore(
        name: 'equipment',
        assets: equipmentAssets,
        comment: 'Equipment sounds',
      );

  /// Terrain sounds.
  final AssetList terrainAssets;

  /// The asset store for terrain sounds.
  AssetStore get terrainAssetStore => getAssetStore(
        name: 'terrain',
        assets: terrainAssets,
        comment: 'Terrain sounds',
      );

  /// The list of assets to be used for ambiances.
  final AssetList ambianceAssets;

  /// The ambiances asset store.
  AssetStore get ambianceAssetStore => getAssetStore(
        name: 'ambiances',
        assets: ambianceAssets,
        comment: 'Ambiance assets',
      );

  /// The assets for use with [Conversation] instances.
  final AssetList conversationAssets;

  /// The conversations asset store.
  AssetStore get conversationAssetStore => getAssetStore(
        name: 'conversations',
        assets: conversationAssets,
        comment: 'Conversation assets',
      );

  /// The quest assets.
  final AssetList questAssets;

  /// The quests asset store.
  AssetStore get questsAssetStore => getAssetStore(
        name: 'quest',
        assets: questAssets,
        comment: 'Quest assets',
      );

  /// The directions that are recognised by this world.
  final DirectionsMap directions;

  /// The positions for equipment.
  final EquipmentPositions equipmentPositions;

  /// The possible terrains.
  final TerrainsList terrains;

  /// Get the terrain with the given [id].
  Terrain getTerrain(final String id) =>
      terrains.firstWhere((final element) => element.id == id);

  /// The list of zones that this world has.
  final ZonesList zones;

  /// Get the zone with the given [id].
  Zone getZone(final String id) =>
      zones.firstWhere((final element) => element.id == id);

  /// The options for the pause menu.
  final PauseMenuOptions pauseMenuOptions;

  /// Get the music for the pause menu.
  Music? get pauseMenuMusic => getMusic(
        assets: musicAssets,
        sound: pauseMenuOptions.music,
      );

  /// The reverb references to use.
  final ReverbsList reverbs;

  /// Return the reverb with the given [id].
  ReverbPreset getReverb(final String id) =>
      getReverbPresetReference(id).reverbPreset;

  /// Get the reverb reference with the given [id].
  ReverbPresetReference getReverbPresetReference(final String id) =>
      reverbs.firstWhere((final element) => element.id == id);

  /// A list of command categories.
  final CommandCategoryList commandCategories;

  /// Get a list of all commands from the [commandCategories].
  CommandList get commands =>
      [for (final category in commandCategories) ...category.commands];

  /// Get the command with the given [id].
  WorldCommand getCommand(final String id) =>
      commands.firstWhere((final element) => element.id == id);

  /// The default player preferences.
  final PlayerPreferences defaultPlayerPreferences;

  /// The [Conversation] categories to use.
  final ConversationCategoryList conversationCategories;

  /// Every conversation from every category.
  List<Conversation> get conversations => [
        for (final category in conversationCategories) ...category.conversations
      ];

  /// Get the conversation with the given [id].
  Conversation getConversation(final String id) =>
      conversations.firstWhere((final element) => element.id == id);

  /// All the quests in the world.
  final QuestList quests;

  /// Get the quest with the given [id].
  Quest getQuest(final String id) =>
      quests.firstWhere((final element) => element.id == id);

  /// The options for the quest menu.
  final QuestMenuOptions questMenuOptions;

  /// The scenes that are part of this world.
  final SceneList scenes;

  /// Get the scene with the given [id].
  Scene getScene(final String id) =>
      scenes.firstWhere((final element) => element.id == id);

  /// The stats for this world.
  final StatList stats;

  /// Get the stat with the given [id].
  WorldStat getStat(final String id) =>
      stats.firstWhere((final element) => element.id == id);

  /// The default player stats.
  final Map<String, int> defaultPlayerStats;

  /// The NPC's which belong to this world.
  final List<Npc> npcs;

  /// Return the NPC with the given [id].
  Npc getNpc(final String id) =>
      npcs.firstWhere((final element) => element.id == id);

  /// The created channel busses.
  final List<AudioBus> audioBusses;

  /// Get the audio bus with the given [id].
  AudioBus getAudioBus(final String id) =>
      audioBusses.firstWhere((final element) => element.id == id);

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldToJson(this);
}
