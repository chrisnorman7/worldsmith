/// Provides the [NpcCollision] class.
import 'package:json_annotation/json_annotation.dart';

import '../commands/call_command.dart';
import '../commands/world_command.dart';
import 'npc.dart';

part 'npc_collision.g.dart';

/// Configure NPC collisions.
@JsonSerializable()
class NpcCollision {
  /// Create an instance.
  NpcCollision({
    this.callCommand,
    this.distance = 1.0,
    this.collideWithNpcs = false,
    this.collideWithPlayer = true,
    this.collideWithObjects = false,
  });

  /// Create an instance from a JSON object.
  factory NpcCollision.fromJson(final Map<String, dynamic> json) =>
      _$NpcCollisionFromJson(json);

  /// The ID of a [WorldCommand] to run.
  CallCommand? callCommand;

  /// The maximum distance before collision occurs.
  double distance;

  /// Whether to collide with the player.
  bool collideWithPlayer;

  /// Whether to collide with other [Npc]'s.
  bool collideWithNpcs;

  /// Whether the NPC should collide with objects.
  bool collideWithObjects;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$NpcCollisionToJson(this);
}
