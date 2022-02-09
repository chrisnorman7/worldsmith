/// Provides the [World] class.
import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import '../../constants.dart';
import '../../extensions.dart';
import 'equipment_position.dart';
import 'options/credits_menu_options.dart';
import 'options/main_menu_options.dart';
import 'options/pause_menu_options.dart';
import 'options/sound_options.dart';
import 'options/world_options.dart';
import 'world_credit.dart';
import 'zones/terrain.dart';
import 'zones/zone.dart';

part 'world.g.dart';

/// The top-level world object.
@JsonSerializable()
class World {
  /// Create an instance.
  const World({
    this.title = 'Untitled World',
    this.globalOptions = const WorldOptions(),
    this.soundOptions = const SoundOptions(),
    this.mainMenuOptions = const MainMenuOptions(),
    this.credits = const [],
    this.creditsMenuOptions = const CreditsMenuOptions(),
    this.creditsAssetStore = const AssetStore(
      filename: 'assets/credits.json',
      destination: 'assets/credits',
      assets: [],
    ),
    this.musicAssetStore = const AssetStore(
      filename: 'assets/music.json',
      destination: 'assets/music',
      assets: [],
    ),
    this.interfaceSoundsAssetStore = const AssetStore(
      filename: 'assets/interface.json',
      destination: 'assets/interface',
      assets: [],
    ),
    this.equipmentAssetStore = const AssetStore(
      filename: 'assets/equipment.json',
      destination: 'assets/equipment',
      assets: [],
    ),
    this.terrainAssetStore = const AssetStore(
      filename: 'assets/terrain.json',
      destination: 'assets/terrains',
      assets: [],
    ),
    this.directions = defaultDirections,
    this.equipmentPositions = const [],
    this.terrains = const [],
    this.zones = const [],
    this.pauseMenuOptions = const PauseMenuOptions(),
  });

  /// Create an instance from a JSON object.
  factory World.fromJson(Map<String, dynamic> json) => _$WorldFromJson(json);

  /// The title of the world.
  final String title;

  /// The options for this world.
  final WorldOptions globalOptions;

  /// Sound configuration.
  final SoundOptions soundOptions;

  /// The options for the main menu.
  final MainMenuOptions mainMenuOptions;

  /// The music for the main menu.
  Ambiance? get mainMenuMusic {
    final sound = mainMenuOptions.music;
    if (sound != null) {
      final asset = musicAssetStore.getAssetReferenceFromVariableName(sound.id);
      return Ambiance(sound: asset!, gain: sound.gain);
    }
    return null;
  }

  /// The credits for this world.
  final List<WorldCredit> credits;

  /// The configuration for the credits menu.
  final CreditsMenuOptions creditsMenuOptions;

  /// The music for the credits menu.
  AssetReference? get creditsMenuMusic => musicAssetStore
      .getAssetReferenceFromVariableName(creditsMenuOptions.music?.id);

  /// The asset store for credit sounds.
  final AssetStore creditsAssetStore;

  /// The asset store for music.
  final AssetStore musicAssetStore;

  /// The interface sounds asset store.
  final AssetStore interfaceSoundsAssetStore;

  /// The asset store for clothing and weapon sounds.
  final AssetStore equipmentAssetStore;

  /// The asset store for terrain sounds.
  final AssetStore terrainAssetStore;

  /// The directions that are recognised by this world.
  final Map<String, double> directions;

  /// The positions for equipment.
  final List<EquipmentPosition> equipmentPositions;

  /// The possible terrains.
  final List<Terrain> terrains;

  /// Get the terrain with the given [id].
  Terrain getTerrain(String id) =>
      terrains.firstWhere((element) => element.id == id);

  /// The list of zones that this world has.
  final List<Zone> zones;

  /// Get the zone with the given [id].
  Zone getZone(String id) => zones.firstWhere((element) => element.id == id);

  /// The options for the pause menu.
  final PauseMenuOptions pauseMenuOptions;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldToJson(this);
}
