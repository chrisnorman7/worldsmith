/// Provides the [World] class.
import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import '../../constants.dart';
import '../../util.dart';
import 'equipment_position.dart';
import 'options/credits_menu_options.dart';
import 'options/main_menu_options.dart';
import 'options/pause_menu_options.dart';
import 'options/sound_options.dart';
import 'options/world_options.dart';
import 'reverb_preset_reference.dart';
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

/// The top-level world object.
@JsonSerializable()
class World {
  /// Create an instance.
  World({
    this.title = 'Untitled World',
    WorldOptions? globalOptions,
    SoundOptions? soundOptions,
    MainMenuOptions? mainMenuOptions,
    CreditsList? credits,
    CreditsMenuOptions? creditsMenuOptions,
    AssetList? creditsAssets,
    AssetList? musicAssets,
    AssetList? interfaceSoundsAssets,
    AssetList? equipmentAssets,
    AssetList? terrainAssets,
    DirectionsMap? directions,
    EquipmentPositions? equipmentPositions,
    TerrainsList? terrains,
    ZonesList? zones,
    PauseMenuOptions? pauseMenuOptions,
    ReverbsList? reverbs,
  })  : globalOptions = globalOptions ?? WorldOptions(),
        soundOptions = soundOptions ?? SoundOptions(),
        mainMenuOptions = mainMenuOptions ?? MainMenuOptions(),
        credits = credits ?? [],
        creditsMenuOptions = creditsMenuOptions ?? CreditsMenuOptions(),
        creditsAssets = creditsAssets ?? [],
        musicAssets = musicAssets ?? [],
        interfaceSoundsAssets = interfaceSoundsAssets ?? [],
        equipmentAssets = equipmentAssets ?? [],
        terrainAssets = terrainAssets ?? [],
        directions = directions ??
            defaultDirections.map(
              MapEntry.new,
            ),
        equipmentPositions = equipmentPositions ?? [],
        terrains = terrains ?? [],
        zones = zones ?? [],
        pauseMenuOptions = pauseMenuOptions ?? PauseMenuOptions(),
        reverbs = reverbs ?? [];

  /// Create an instance from a JSON object.
  factory World.fromJson(Map<String, dynamic> json) => _$WorldFromJson(json);

  /// The title of the world.
  String title;

  /// The options for this world.
  final WorldOptions globalOptions;

  /// Sound configuration.
  final SoundOptions soundOptions;

  /// Get the menu move sound.
  AssetReference? get menuMoveSound => getAssetReferenceReference(
          assets: interfaceSoundsAssets, id: soundOptions.menuMoveSound?.id)
      ?.reference;

  /// The menu activate sound.
  AssetReference? get menuActivateSound => getAssetReferenceReference(
          assets: interfaceSoundsAssets, id: soundOptions.menuMoveSound?.id)
      ?.reference;

  /// The options for the main menu.
  final MainMenuOptions mainMenuOptions;

  /// The music for the main menu.
  Ambiance? get mainMenuMusic {
    final sound = mainMenuOptions.music;
    if (sound != null) {
      final assetReference = getAssetReferenceReference(
        assets: musicAssets,
        id: sound.id,
      )!
          .reference;
      return Ambiance(sound: assetReference, gain: sound.gain);
    }
    return null;
  }

  /// The credits for this world.
  final CreditsList credits;

  /// The configuration for the credits menu.
  final CreditsMenuOptions creditsMenuOptions;

  /// The music for the credits menu.
  AssetReference? get creditsMenuMusic => getAssetReferenceReference(
        assets: musicAssets,
        id: creditsMenuOptions.music?.id,
      )?.reference;

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
      name: 'terrain', assets: terrainAssets, comment: 'Terrain sounds');

  /// The directions that are recognised by this world.
  final DirectionsMap directions;

  /// The positions for equipment.
  final EquipmentPositions equipmentPositions;

  /// The possible terrains.
  final TerrainsList terrains;

  /// Get the terrain with the given [id].
  Terrain getTerrain(String id) =>
      terrains.firstWhere((element) => element.id == id);

  /// The list of zones that this world has.
  final ZonesList zones;

  /// Get the zone with the given [id].
  Zone getZone(String id) => zones.firstWhere((element) => element.id == id);

  /// The options for the pause menu.
  final PauseMenuOptions pauseMenuOptions;

  /// The reverb references to use.
  final ReverbsList reverbs;

  /// Return the reverb with the given [id].
  ReverbPreset getReverb(String id) => reverbs
      .firstWhere(
        (element) => element.id == id,
      )
      .reverbPreset;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldToJson(this);
}
