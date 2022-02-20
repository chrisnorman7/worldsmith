import 'package:json_annotation/json_annotation.dart';

import '../zones/coordinates.dart';
import '../zones/zone.dart';
import 'local_teleport.dart';

part 'zone_teleport.g.dart';

/// An instruction to move to a [Zone] instance.
@JsonSerializable()
class ZoneTeleport extends LocalTeleport {
  /// Create an instance.
  ZoneTeleport({
    required this.zoneId,
    required Coordinates minCoordinates,
    Coordinates? maxCoordinates,
    this.fadeTime,
  }) : super(minCoordinates: minCoordinates, maxCoordinates: maxCoordinates);

  /// Create an instance from a JSON object.
  factory ZoneTeleport.fromJson(Map<String, dynamic> json) =>
      _$ZoneTeleportFromJson(json);

  /// The ID of the zone to go to.
  String zoneId;

  /// The fade time to use.
  double? fadeTime;

  /// Convert an instance to JSON.
  @override
  Map<String, dynamic> toJson() => _$ZoneTeleportToJson(this);
}
