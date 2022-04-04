/// Provides the [Npc] class.
import 'package:json_annotation/json_annotation.dart';

import '../sound.dart';
import '../stats/statistics.dart';
import '../zones/coordinates.dart';
import 'npc_collision.dart';
import 'npc_move.dart';

part 'npc.g.dart';

/// A non-player character.
@JsonSerializable()
class Npc {
  /// Create an instance.
  Npc({
    required this.id,
    required this.coordinates,
    required this.stats,
    this.name = 'Unnamed NPC',
    this.ambiance,
    final List<NpcMove>? moves,
    this.collision,
  }) : moves = moves ?? [];

  /// Create an instance from a JSON object.
  factory Npc.fromJson(final Map<String, dynamic> json) => _$NpcFromJson(json);

  /// The ID of this NPC.
  final String id;

  /// The name of this NPC.
  String name;

  /// The coordinates where this NPC will pop.
  Coordinates coordinates;

  /// The stats for this NPC.
  final Statistics stats;

  /// The ambiance that will play for this NPC.
  Sound? ambiance;

  /// The moves this NPC will make.
  final List<NpcMove> moves;

  /// What happens when this NPC collides with something else.
  NpcCollision? collision;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$NpcToJson(this);
}
