/// Provides the [ZoneObject] class.
import 'package:json_annotation/json_annotation.dart';

import '../commands/call_command.dart';
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
    final Coordinates? initialCoordinates,
    this.ambiance,
    this.collideCommand,
  }) : initialCoordinates = initialCoordinates ?? Coordinates(0, 0);

  /// Create an instance from a JSON object.
  factory ZoneObject.fromJson(final Map<String, dynamic> json) =>
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
  CallCommand? collideCommand;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ZoneObjectToJson(this);
}
