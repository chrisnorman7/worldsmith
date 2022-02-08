/// Provides the [World] class.
import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import '../../extensions.dart';
import '../../worldsmith.dart';
import 'equipment_position.dart';
import 'options/sound_options.dart';

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
    this.creditsMenuOptions = const MenuOptions(title: 'Credits'),
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
    this.equipmentPositions = const [],
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

  /// The sound that will play when the player moves in a menu.
  AssetReference? get menuMoveSound => interfaceSoundsAssetStore
      .getAssetReferenceFromVariableName(soundOptions.menuMoveSoundId);

  /// The sound that will play when a menu item is activated.
  AssetReference? get menuActivateSound => interfaceSoundsAssetStore
      .getAssetReferenceFromVariableName(soundOptions.menuActivateSoundId);

  /// The music for the main menu.
  AssetReference? get mainMenuMusic => musicAssetStore
      .getAssetReferenceFromVariableName(mainMenuOptions.options.musicId);

  /// The credits for this world.
  final List<WorldCredit> credits;

  /// The configuration for the credits menu.
  final MenuOptions creditsMenuOptions;

  /// The music for the credits menu.
  AssetReference? get creditsMenuMusic => musicAssetStore
      .getAssetReferenceFromVariableName(creditsMenuOptions.musicId);

  /// The asset store for credit sounds.
  final AssetStore creditsAssetStore;

  /// The asset store for music.
  final AssetStore musicAssetStore;

  /// The interface sounds asset store.
  final AssetStore interfaceSoundsAssetStore;

  /// The asset store for clothing and weapon sounds.
  final AssetStore equipmentAssetStore;

  /// The positions for equipment.
  final List<EquipmentPosition> equipmentPositions;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldToJson(this);
}
