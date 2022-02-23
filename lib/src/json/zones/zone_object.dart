/// Provides the [ZoneObject] class.
import 'package:json_annotation/json_annotation.dart';

import '../sound.dart';
import 'coordinates.dart';
import 'zone.dart';

part 'zone_object.g.dart';

/// An object in a [Zone].
@JsonSerializable()
class ZoneObject {
  /// Create an instance.
  ZoneObject({
    required this.id,
    required this.name,
    Coordinates? initialCoordinates,
    this.ambiance,
    this.collideCommandId,
  }) : initialCoordinates = initialCoordinates ?? Coordinates(0, 0);

  /// Create an instance from a JSON object.
  factory ZoneObject.fromJson(Map<String, dynamic> json) =>
      _$ZoneObjectFromJson(json);

  /// The ID of this object.
  final String id;

  /// THe name of this object.
  String name;

  /// THe initial coordinates of this object.
  final Coordinates initialCoordinates;

  /// The ambiance for this object.
  Sound? ambiance;

  /// The ID of a command to run when the player collides with this object.
  String? collideCommandId;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ZoneObjectToJson(this);
}
