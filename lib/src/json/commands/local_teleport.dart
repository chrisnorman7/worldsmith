import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

import '../zones/coordinates.dart';
import '../zones/zone.dart';

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
}
