import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

import '../zones/coordinates.dart';
import '../zones/zone.dart';

part 'zone_teleport.g.dart';

/// An instruction to move to a [Zone] instance.
@JsonSerializable()
class ZoneTeleport {
  /// Create an instance.
  ZoneTeleport({
    required this.zoneId,
    required this.minCoordinates,
    this.maxCoordinates,
    this.fadeTime,
    this.heading = 0,
  });

  /// Create an instance from a JSON object.
  factory ZoneTeleport.fromJson(Map<String, dynamic> json) =>
      _$ZoneTeleportFromJson(json);

  /// The ID of the zone to go to.
  String zoneId;

  /// The fade time to use.
  double? fadeTime;

  /// The minimum coordinates to appear at.
  final Coordinates minCoordinates;

  /// The maximum coordinates to appear at.
  ///
  /// If this value is `null`, then [minCoordinates] will be used with no
  /// randomisation.
  Coordinates? maxCoordinates;

  /// The new heading to use.
  int heading;

  /// Get an appropriate set of coordinates to use.
  ///
  /// If [maxCoordinates] is `null`, `[minCoordinates] will be returned.
  /// Otherwise, a set of random coordinates between the two will be returned.
  Point<int> getCoordinates({
    required Zone zone,
    required Random random,
  }) {
    final lower = zone.getAbsoluteCoordinates(minCoordinates);
    final end = maxCoordinates;
    if (end == null) {
      return lower;
    }
    final upper = zone.getAbsoluteCoordinates(end);
    final startX = min(lower.x, upper.x);
    final startY = min(lower.y, upper.y);
    final endX = max(lower.x, upper.x);
    final endY = max(lower.y, upper.y);
    return Point(
      startX + random.nextInt(endX),
      startY + random.nextInt(endY),
    );
  }

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ZoneTeleportToJson(this);
}
