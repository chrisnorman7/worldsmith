/// Provides the [World] class.
import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'world_credit.dart';
import 'world_options.dart';

part 'world.g.dart';

/// The top-level world object.
@JsonSerializable()
class World {
  /// Create an instance.
  const World({
    required this.title,
    required this.options,
    required this.credits,
    required this.creditsAssetStore,
    required this.musicAssetStore,
    required this.interfaceSoundsAssetStore,
  });

  /// Create an instance from a JSON object.
  factory World.fromJson(Map<String, dynamic> json) => _$WorldFromJson(json);

  /// The title of the world.
  final String title;

  /// The options for this world.
  final WorldOptions options;

  /// The credits for this world.
  final List<WorldCredit> credits;

  /// The asset store for credit sounds.
  final AssetStore creditsAssetStore;

  /// The asset store for music.
  final AssetStore musicAssetStore;

  /// The interface sounds asset store.
  final AssetStore interfaceSoundsAssetStore;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldToJson(this);
}
