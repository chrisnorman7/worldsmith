import 'dart:math';

import 'package:ziggurat/sound.dart';

import '../json/npcs/npc.dart';
import '../json/npcs/npc_move.dart';
import '../json/npcs/zone_npc.dart';

/// A context for an [Npc].
class NpcContext {
  /// Create an instance.
  NpcContext({
    required this.zoneNpc,
    required this.coordinates,
    required this.channel,
    this.ambiance,
    this.timeUntilMove = 0,
  });

  /// The NPC that this context represents.
  final ZoneNpc zoneNpc;

  /// The coordinates of this NPC.
  Point<double> coordinates;

  /// The channel to play sounds through.
  final SoundChannel channel;

  /// The ambiance to play.
  final PlaySound? ambiance;

  /// The last sound emitted by this NPC.
  PlaySound? lastSound;

  /// The last movement sound for this NPC.
  PlaySound? lastMovementSound;

  /// The index of the [NpcMove] this is being acted out.
  int? moveIndex;

  /// The current move.
  NpcMove get move {
    final index = moveIndex;
    if (index == null) {
      throw StateError('The NPC with ID ${zoneNpc.npcId} has not moved yet.');
    }
    return zoneNpc.moves[index];
  }

  /// How many millisecond are left until the NPC must move again.
  int timeUntilMove;

  /// Set [timeUntilMove] according to the values on the [zoneNpc].
  void resetTimeUntilMove({required final Random random, final NpcMove? move}) {
    if (move == null) {
      timeUntilMove = 0;
    } else {
      if (move.minMoveInterval == move.maxMoveInterval) {
        timeUntilMove = move.minMoveInterval;
      } else {
        final a = min(move.minMoveInterval, move.maxMoveInterval);
        final b = max(move.minMoveInterval, move.maxMoveInterval);
        timeUntilMove = a + random.nextInt(b - a);
      }
    }
  }
}
