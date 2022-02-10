/// Provides the [Terrain] class.
import 'package:json_annotation/json_annotation.dart';

import '../options/walking_options.dart';
import 'box.dart';

part 'terrain.g.dart';

/// The terrain of a [Box] instance.
@JsonSerializable()
class Terrain {
  /// Create an instance.
  const Terrain({
    required this.id,
    required this.name,
    required this.slowWalk,
    required this.fastWalk,
  });

  /// Create an instance from a JSON object.
  factory Terrain.fromJson(Map<String, dynamic> json) =>
      _$TerrainFromJson(json);

  /// The ID of this terrain.
  final String id;

  /// The name of this terrain type.
  final String name;

  /// Slow walk configuration.
  final WalkingOptions slowWalk;

  /// Fast walking options.
  final WalkingOptions fastWalk;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$TerrainToJson(this);
}
