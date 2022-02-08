/// Provides the [Terrain] class.
import 'package:json_annotation/json_annotation.dart';

import 'box.dart';

part 'terrain.g.dart';

/// The terrain of a [Box] instance.
@JsonSerializable()
class Terrain {
  /// Create an instance.
  const Terrain({
    required this.id,
    required this.name,
    required this.assetId,
  });

  /// Create an instance from a JSON object.
  factory Terrain.fromJson(Map<String, dynamic> json) =>
      _$TerrainFromJson(json);

  /// The ID of this terrain.
  final String id;

  /// The name of this terrain type.
  final String name;

  /// The ID of the asset in the terrains asset store that will play for this
  /// terrain.
  final String assetId;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$TerrainToJson(this);
}
