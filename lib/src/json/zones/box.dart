/// Provides the [Box] class.
import 'package:json_annotation/json_annotation.dart';

import 'coordinates.dart';
import 'zone.dart';

part 'box.g.dart';

/// A box within a [Zone].
@JsonSerializable()
class Box {
  /// Create an instance.
  Box({
    required this.id,
    required this.name,
    required this.start,
    required this.end,
    required this.terrainId,
    this.enclosed = false,
    this.reverbId,
  });

  /// Create an instance from a JSON object.
  factory Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);

  /// The ID of this box.
  final String id;

  /// The name of this box.
  String name;

  /// The start coordinates of this box.
  Coordinates start;

  /// The end coordinates of this box.
  Coordinates end;

  /// The ID of the type of terrain for this box.
  String terrainId;

  /// Whether or not this box is enclosed.
  ///
  /// If this value is `true`, sounds from the outside will be inaudible.
  bool enclosed;

  /// The ID of the reverb preset to use in this box.
  String? reverbId;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$BoxToJson(this);

  /// Describe this object.
  @override
  String toString() => '<$runtimeType $name>';

  /// Return the hash code of [id].
  @override
  int get hashCode => id.hashCode;

  /// Compare 2 objects.
  @override
  bool operator ==(Object other) {
    if (other is Box) {
      return other.id == id;
    }
    return super == other;
  }
}
