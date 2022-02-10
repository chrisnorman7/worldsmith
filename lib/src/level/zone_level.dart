/// Provides the [ZoneLevel] class.
import 'dart:math';

import 'package:ziggurat/levels.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../command_triggers.dart';
import '../../extensions.dart';
import '../json/world.dart';
import '../json/zones/box.dart';
import '../json/zones/zone.dart';
import 'pause_menu.dart';

const _origin = Point(0.0, 0.0);

/// A level for playing through a zone.
class ZoneLevel extends Level {
  /// Create an instance.
  ZoneLevel({
    required Game game,
    required this.world,
    required this.zone,
    this.coordinates = _origin,
    this.heading = 0,
  }) : super(
          game: game,
          ambiances: [
            if (zone.music != null)
              world.musicAssetStore.getAmbiance(zone.music!)
          ],
        ) {
    commands[pauseMenuCommandTrigger.name] = Command(
      onStart: () => game.pushLevel(
        PauseMenu(
          game: game,
          world: world,
          zone: zone,
        ),
      ),
    );
    commands[showCoordinatesCommandTrigger.name] = Command(
      onStart: showCoordinates,
    );
    commands[showFacingCommandTrigger.name] = Command(
      onStart: showFacing,
    );
    var minCoordinates = Point(0, 0);
    var maxCoordinates = Point(0, 0);
    // First pass: Get the minimum and maximum coordinates.
    for (final box in zone.boxes) {
      final start = zone.getAbsoluteCoordinates(box.start);
      final end = zone.getAbsoluteCoordinates(box.end);
      minCoordinates = Point(
        min(minCoordinates.x, start.x),
        min(minCoordinates.y, start.y),
      );
      maxCoordinates = Point(
        max(maxCoordinates.x, end.x),
        max(maxCoordinates.y, end.y),
      );
    }
    coordinatesOffset = Point(
      minCoordinates.x < 0 ? minCoordinates.x * -1 : 0,
      minCoordinates.y < 0 ? minCoordinates.y * -1 : 0,
    );
    // Null all the tiles.
    tiles = List.generate(
      maxCoordinates.x + coordinatesOffset.x,
      (x) => List.generate(
        maxCoordinates.y + coordinatesOffset.y,
        (y) => null,
      ),
    );
    // Second pass: Change `null` to box indices.
    for (var i = 0; i < zone.boxes.length; i++) {
      final box = zone.boxes[i];
      final start = zone.getAbsoluteCoordinates(box.start);
      final end = zone.getAbsoluteCoordinates(box.end);
      for (var x = start.x + coordinatesOffset.x;
          x < end.x + coordinatesOffset.x;
          x++) {
        for (var y = start.y + coordinatesOffset.y;
            y < end.y + coordinatesOffset.y;
            y++) {
          tiles[x][y] = i;
        }
      }
    }
  }

  /// The world to get metadata from.
  final World world;

  /// The zone to use.
  final Zone zone;

  /// The direction the player is facing in.
  double heading;

  /// The coordinates of the player.
  Point<double> coordinates;

  /// The loaded tiles.
  late final List<List<int?>> tiles;

  /// The difference between the origin and the minimum coordinates from boxes.
  late final Point<int> coordinatesOffset;

  /// Get the box that resides at the provided [coordinates].
  Box? getBox([Point<double>? where]) {
    where ??= coordinates;
    final index = tiles[where.x.floor()][where.y.floor()];
    if (index == null) {
      return null;
    }
    return zone.boxes[index];
  }

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
