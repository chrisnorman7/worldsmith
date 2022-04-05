/// Provides the [ZoneNpc] class.
import 'package:json_annotation/json_annotation.dart';

import '../zones/coordinates.dart';
import '../zones/zone.dart';
import 'npc.dart';
import 'npc_collision.dart';
import 'npc_move.dart';

part 'zone_npc.g.dart';

/// A class for connecting [Npc]'s to [Zone]s.
@JsonSerializable()
class ZoneNpc {
  /// Create an instance.
  ZoneNpc({
    required this.npcId,
    required this.initialCoordinates,
    this.z = 0.0,
    final List<NpcMove>? moves,
    this.collision,
  }) : moves = moves ?? [];

  /// Create an instance from a JSON object.
  factory ZoneNpc.fromJson(final Map<String, dynamic> json) =>
      _$ZoneNpcFromJson(json);

  /// The ID of the [Npc] this instance represents.
  final String npcId;

  /// The coordinates where this NPC will pop.
  Coordinates initialCoordinates;

  /// The z coordinate for this NPC.
  ///
  /// If you change this coordinate, then sounds made by this NPC will appear to
  /// come above or below.
  double z;

  /// The moves this NPC will perform.
  final List<NpcMove> moves;

  /// What happens when this NPC collides with something else.
  NpcCollision? collision;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ZoneNpcToJson(this);
}
