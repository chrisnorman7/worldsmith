/// Provides the [Box] class.
import 'package:json_annotation/json_annotation.dart';

import 'coordinates.dart';
import 'zone.dart';

part 'box.g.dart';

/// A box within a [Zone].
@JsonSerializable()
class Box {
  /// Create an instance.
  const Box({
    required this.id,
    required this.name,
    required this.start,
    required this.end,
    required this.terrainId,
    this.enclosed = false,
  });

  /// Create an instance from a JSON object.
  factory Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);

  /// The ID of this box.
  final String id;

  /// The name of this box.
  final String name;

  /// The start coordinates of this box.
  final Coordinates start;

  /// The end coordinates of this box.
  final Coordinates end;

  /// The ID of the type of terrain for this box.
  final String terrainId;

  /// Whether or not this box is enclosed.
  ///
  /// If this value is `true`, sounds from the outside will be inaudible.
  final bool enclosed;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$BoxToJson(this);
}
