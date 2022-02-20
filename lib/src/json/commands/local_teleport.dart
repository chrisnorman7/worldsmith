import 'package:json_annotation/json_annotation.dart';

import '../zones/coordinates.dart';

part 'local_teleport.g.dart';

/// An instruction to teleport somewhere in the current zone.
@JsonSerializable()
class LocalTeleport {
  /// Create an instance.
  LocalTeleport({required this.minCoordinates, this.maxCoordinates});

  /// Create an instance from a JSON object.
  factory LocalTeleport.fromJson(Map<String, dynamic> json) =>
      _$LocalTeleportFromJson(json);

  /// The minimum coordinates to appear at.
  final Coordinates minCoordinates;

  /// The maximum coordinates to appear at.
  ///
  /// If this value is `null`, then [minCoordinates] will be used with no
  /// randomisation.
  Coordinates? maxCoordinates;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$LocalTeleportToJson(this);
}
