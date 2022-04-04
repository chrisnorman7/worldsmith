/// Provides the [NpcMove] class.
import 'package:json_annotation/json_annotation.dart';

import '../../levels/walking_mode.dart';
import '../sound.dart';
import '../zones/location_marker.dart';
import 'npc.dart';

part 'npc_move.g.dart';

/// A [Npc] move.
@JsonSerializable()
class NpcMove {
  /// Create an instance.
  NpcMove({
    required this.locationMarkerId,
    this.minMoveInterval = 100,
    this.maxMoveInterval = 5000,
    this.moveSound,
    this.walkingMode,
  });

  /// Create an instance from a JSON object.
  factory NpcMove.fromJson(final Map<String, dynamic> json) =>
      _$NpcMoveFromJson(json);

  /// The ID of the [LocationMarker] to move to.
  String locationMarkerId;

  /// The minimum number of milliseconds between steps.
  int minMoveInterval;

  /// The maximum number of milliseconds between steps.
  int maxMoveInterval;

  /// The sound that should play when this move is performed.
  ///
  /// If this value is `null`, the normal terrain sound will be used.
  Sound? moveSound;

  /// The walking mode to use.
  ///
  /// If this value is `null`, then moves will be silent.
  WalkingMode? walkingMode;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$NpcMoveToJson(this);
}
