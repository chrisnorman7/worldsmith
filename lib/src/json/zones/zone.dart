/// Provides the [Zone] class.
import 'package:json_annotation/json_annotation.dart';

import '../world.dart';
import 'box.dart';

part 'zone.g.dart';

/// A zone in a [World] instance.
@JsonSerializable()
class Zone {
  /// Create an instance.
  const Zone({
    required this.id,
    required this.name,
    required this.boxes,
    this.topDownMap = true,
  });

  /// Create an instance from a JSON object.
  factory Zone.fromJson(Map<String, dynamic> json) => _$ZoneFromJson(json);

  /// The ID of this zone.
  final String id;

  /// The name of this zone.
  final String name;

  /// The boxes in this zone.
  final List<Box> boxes;

  /// Whether or not a top-down map of this zone can be viewed.
  final bool topDownMap;

  /// Get a box by its [id].
  Box getBox(String id) => boxes.firstWhere((element) => element.id == id);

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ZoneToJson(this);
}
