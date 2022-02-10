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

/// The possible walking modes.
enum WalkingMode {
  /// The player is stationary.
  stationary,

  /// The player is walking slowly.
  slow,

  /// The player is walking fast.
  fast,
}

/// A level for playing through a zone.
class ZoneLevel extends Level {
  /// Create an instance.
  ZoneLevel({
    required Game game,
    required this.world,
    required this.zone,
    int heading = 0,
    Point<double> coordinates = _origin,
    this.walkingMode = WalkingMode.stationary,
    this.lastWalk = 0,
  })  : _heading = heading,
        _coordinates = coordinates,
        super(
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
  int _heading;

  /// Get the player's current heading.
  int get heading => _heading;

  /// Set the player's heading.
  set heading(int value) {
    _heading = value;
    game.setListenerOrientation(value.toDouble());
  }

  /// The coordinates of the player.
  Point<double> _coordinates;

  /// Get the player's current coordinates.
  Point<double> get coordinates => _coordinates;

  /// How fast the player is walking.
  WalkingMode walkingMode;

  /// The time the player last took a step.
  int lastWalk;

  /// The loaded tiles.
  late final List<List<int?>> tiles;

  /// The difference between the origin and the minimum coordinates from boxes.
  late final Point<int> coordinatesOffset;

  /// Get the box that resides at the provided [coordinates].
  Box? getBox([Point<double>? where]) {
    where ??= _coordinates;
    final index = tiles[where.x.floor()][where.y.floor()];
    if (index == null) {
      return null;
    }
    return zone.boxes[index];
  }

  /// Show the current coordinates.
  void showCoordinates() {
    final x = coordinates.x.floor();
    final y = coordinates.y.floor();
    game.outputText('$x, $y');
  }

  /// Show the facing direction.
  void showFacing() {
    String? direction;
    int? difference;
    for (final entry in world.directions.entries) {
      final value = entry.value.floor();
      final d = max<int>(_heading, value) - min<int>(_heading, value);
      if (difference == null || difference > d) {
        difference = d;
        direction = entry.key;
      }
    }
    if (direction != null) {
      game.outputText(direction);
    }
  }

  /// Set the listener's position according to [coordinates].
  set coordinates(Point<double> value) {
    _coordinates = value;
    game.setListenerPosition(value.x, value.y, 0.0);
  }

  /// Reset state.
  void resetState() {
    coordinates = _coordinates;
    heading = _heading;
  }

  /// Set the listener position ETC.
  @override
  void onPush() {
    super.onPush();
    resetState();
  }

  /// Reset state.
  @override
  void onReveal(Level old) {
    super.onReveal(old);
    resetState();
  }
}
