/// Provides the [ZoneLevel] class.
import 'dart:math';

import 'package:ziggurat/levels.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../command_triggers.dart';
import '../../extensions.dart';
import '../json/world.dart';
import '../json/zones/zone.dart';
import 'pause_menu.dart';

/// A level for playing through a zone.
class ZoneLevel extends Level {
  /// Create an instance.
  ZoneLevel({
    required Game game,
    required this.world,
    required this.zone,
    required this.coordinates,
    this.heading = 0,
  }) : super(
          game: game,
          ambiances: [
            if (zone.musicId != null)
              Ambiance(
                  sound: world.musicAssetStore
                      .getAssetReferenceFromVariableName(zone.musicId)!),
          ],
        ) {
    commands[pauseMenuCommandTrigger.name] = Command(
      onStart: () => game.pushLevel(PauseMenu(
        game: game,
        world: world,
        zone: zone,
      )),
    );
    commands[showCoordinatesCommandTrigger.name] = Command(
      onStart: showCoordinates,
    );
    commands[showFacingCommandTrigger.name] = Command(
      onStart: showFacing,
    );
  }

  /// The world to get metadata from.
  final World world;

  /// The zone to use.
  final Zone zone;

  /// The direction the player is facing in.
  double heading;

  /// The coordinates of the player.
  Point<double> coordinates;

  /// Show the current coordinates.
  void showCoordinates() {
    final x = coordinates.x.toStringAsFixed(2);
    final y = coordinates.y.toStringAsFixed(2);
    game.outputText('$x, $y');
  }

  /// Show the facing direction.
  void showFacing() {
    String? direction;
    double? difference;
    for (final entry in world.directions.entries) {
      final d = max(heading, entry.value) - min(heading, entry.value);
      if (difference == null || difference > d) {
        difference = d;
        direction = entry.key;
      }
    }
    if (direction != null) {
      game.outputText(direction);
    }
  }

  /// Set the listener position ETC.
  @override
  void onPush() {
    super.onPush();
    game
      ..setListenerPosition(coordinates.x, coordinates.y, 0.0)
      ..setListenerOrientation(heading.toDouble());
  }
}
