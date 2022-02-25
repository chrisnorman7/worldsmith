import 'package:json_annotation/json_annotation.dart';

import '../zones/coordinates.dart';

part 'local_teleport.g.dart';

/// An instruction to teleport somewhere in the current zone.
@JsonSerializable()
class LocalTeleport {
  /// Create an instance.
  LocalTeleport({
    this.heading = 0,
  });

  /// Create an instance from a JSON object.
  factory LocalTeleport.fromJson(Map<String, dynamic> json) =>
      _$LocalTeleportFromJson(json);

  /// The new heading to use.
  int heading;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$LocalTeleportToJson(this);
}
