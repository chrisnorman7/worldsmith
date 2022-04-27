/// Provides the [Npc] class.
import 'package:json_annotation/json_annotation.dart';

import '../sounds/sound.dart';
import '../stats/statistics.dart';

part 'npc.g.dart';

/// A non-player character.
@JsonSerializable()
class Npc {
  /// Create an instance.
  Npc({
    required this.id,
    required this.stats,
    this.name = 'Unnamed NPC',
    this.ambiance,
  });

  /// Create an instance from a JSON object.
  factory Npc.fromJson(final Map<String, dynamic> json) => _$NpcFromJson(json);

  /// The ID of this NPC.
  final String id;

  /// The name of this NPC.
  String name;

  /// The stats for this NPC.
  final Statistics stats;

  /// The ambiance that will play for this NPC.
  Sound? ambiance;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$NpcToJson(this);
}
