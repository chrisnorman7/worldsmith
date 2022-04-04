/// Provides the [NpcCollision] class.
import 'package:json_annotation/json_annotation.dart';

import '../commands/world_command.dart';
import 'npc.dart';

part 'npc_collision.g.dart';

/// Configure NPC collisions.
@JsonSerializable()
class NpcCollision {
  /// Create an instance.
  NpcCollision({
    required this.commandId,
    this.distance = 1.0,
    this.collideWithNpcs = false,
    this.collideWithPlayer = true,
  });

  /// Create an instance from a JSON object.
  factory NpcCollision.fromJson(final Map<String, dynamic> json) =>
      _$NpcCollisionFromJson(json);

  /// The ID of a [WorldCommand] to run.
  String commandId;

  /// The maximum distance before collision occurs.
  double distance;

  /// Whether to collide with the player.
  bool collideWithPlayer;

  /// Whether to collide with other [Npc]'s.
  bool collideWithNpcs;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$NpcCollisionToJson(this);
}
