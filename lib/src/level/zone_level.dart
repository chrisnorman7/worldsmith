/// Provides the [ZoneLevel] class.
import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:ziggurat/levels.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../command_triggers.dart';
import '../../util.dart';
import '../../world_context.dart';
import '../json/options/walking_options.dart';
import '../json/zones/box.dart';
import '../json/zones/terrain.dart';
import '../json/zones/zone.dart';
import 'walking_mode.dart';

const _origin = Point(0.0, 0.0);

/// A level for playing through a zone.
class ZoneLevel extends Level {
  /// Create an instance.
  ZoneLevel({
    required this.worldContext,
    required this.zone,
    int heading = 0,
    Point<double> coordinates = _origin,
    this.walkingMode = WalkingMode.stationary,
    this.timeSinceLastWalked = 0,
  })  : _heading = heading,
        _coordinates = coordinates,
        affectedInterfaceSounds = worldContext.game.createSoundChannel(),
        boxReverbs = {},
        super(
          game: worldContext.game,
          ambiances: [
            if (zone.music != null)
              getAmbiance(
                assets: worldContext.world.musicAssets,
                sound: zone.music,
              )!
          ],
        ) {
    commands[pauseMenuCommandTrigger.name] = Command(
      onStart: () => game.pushLevel(
        worldContext.pauseMenuBuilder(worldContext, zone),
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
    for (final box in zone.boxes) {
      final start = zone.getAbsoluteCoordinates(box.start);
      final end = zone.getAbsoluteCoordinates(box.end);
      for (var x = start.x + coordinatesOffset.x;
          x < end.x + coordinatesOffset.x;
          x++) {
        for (var y = start.y + coordinatesOffset.y;
            y < end.y + coordinatesOffset.y;
            y++) {
          tiles[x][y] = box.id;
        }
      }
    }
  }

  /// The world context to use.
  final WorldContext worldContext;

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

  /// Set the listener's position.
  set coordinates(Point<double> value) {
    _coordinates = value;
    game.setListenerPosition(value.x, value.y, 0.0);
  }

  /// The sound channel to use for affected interface sounds.
  final SoundChannel affectedInterfaceSounds;

  /// The loaded reverbs.
  final Map<String, CreateReverb> boxReverbs;

  /// How fast the player is walking.
  WalkingMode walkingMode;

  /// The number of milliseconds since the [walk] method was called.
  int timeSinceLastWalked;

  /// The loaded tiles.
  late final List<List<String?>> tiles;

  /// The difference between the origin and the minimum coordinates from boxes.
  late final Point<int> coordinatesOffset;

  /// The size of the [zone].
  ///
  /// As coordinates, the returned value represents a point just northeast of
  /// the northeast corner of the most northeast box.
  Point<int> get size => Point(tiles.length, tiles.first.length);

  /// Get the box that resides at the provided [coordinates].
  ///
  /// If the coordinates are out of range, [RangeError] will be thrown.
  Box? getBox([Point<double>? where]) {
    where ??= _coordinates;
    final id = tiles[where.x.floor()][where.y.floor()];
    if (id == null) {
      return null;
    }
    return zone.getBox(id);
  }

  /// Get the terrain at the current position.
  Terrain getTerrain([Box? box]) {
    box ??= getBox();
    return worldContext.world
        .getTerrain(box?.terrainId ?? zone.defaultTerrainId);
  }

  /// Get the current walking options.
  ///
  /// If there is a box at the current [coordinates], then that box's terrain
  /// will be used.
  ///
  /// Otherwise, the default terrain for the loaded [zone] will be returned.
  ///
  /// If the player is not walking, then `null` will be returned.
  WalkingOptions? getWalkingOptions([Box? box]) {
    final terrain = getTerrain(box);
    switch (walkingMode) {
      case WalkingMode.stationary:
        return null;
      case WalkingMode.slow:
        return terrain.slowWalk;
      case WalkingMode.fast:
        return terrain.fastWalk;
    }
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
    for (final entry in worldContext.world.directions.entries) {
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

  /// Destroy all the created reverbs, and the sound channel.
  @override
  void onPop(double? fadeLength) {
    super.onPop(fadeLength);
    while (boxReverbs.isNotEmpty) {
      boxReverbs.remove(boxReverbs.keys.first)!.destroy();
    }
    affectedInterfaceSounds.destroy();
  }

  /// Get the reverb for the given [box].
  CreateReverb? getReverb(Box box) {
    final reverbId = box.reverbId;
    if (reverbId == null) {
      return null;
    }
    var reverb = boxReverbs[box.id];
    if (reverb == null) {
      reverb = game.createReverb(worldContext.world.getReverb(reverbId));
      boxReverbs[box.id] = reverb;
    }
    return reverb;
  }

  /// Walk a bit.
  void walk(WalkingOptions options) {
    final oldBox = getBox();
    final destination = coordinatesInDirection(
      _coordinates,
      _heading.toDouble(),
      options.distance,
    );
    if (destination.x < 0 || destination.y < 0) {
      // Avoid getting `RangeError` thrown.
      return;
    }
    final newBox = getBox(destination);
    if (newBox != oldBox) {
      // Boxes are different.
      final String text;
      if (newBox == null) {
        affectedInterfaceSounds.setReverb(null);
        if (oldBox != null) {
          text = 'Leaving ${oldBox.name}.';
        } else {
          text = 'Both boxes are null, new box was tested first.';
        }
      } else {
        affectedInterfaceSounds.setReverb(getReverb(newBox));
        if (oldBox == null) {
          text = 'Entering ${newBox.name}.';
        } else {
          text = 'Both boxes are null, old box was tested first.';
        }
      }
      game.outputText(text);
    }
    playSound(
      channel: affectedInterfaceSounds,
      sound: options.sound,
      assets: worldContext.world.terrainAssets,
    );
    coordinates = destination;
    timeSinceLastWalked = 0;
  }

  /// Maybe walk.
  @override
  Future<void> tick(Sdl sdl, int timeDelta) async {
    super.tick(sdl, timeDelta);
    final walkingOptions = getWalkingOptions();
    if (walkingOptions != null) {
      timeSinceLastWalked += timeDelta;
      if (timeSinceLastWalked >= walkingOptions.interval) {
        walk(walkingOptions);
      }
    }
  }

  /// Handle SDL events.
  @override
  void handleSdlEvent(Event event) {
    if (event is ControllerAxisEvent) {
      if (event.axis == GameControllerAxis.lefty) {
        final terrain = getTerrain();
        final value = event.smallValue;
        if (value >= terrain.fastWalk.joystickValue) {
          walkingMode = WalkingMode.fast;
        } else if (value >= terrain.slowWalk.joystickValue) {
          walkingMode = WalkingMode.slow;
        } else {
          walkingMode = WalkingMode.stationary;
        }
      }
    } else {
      super.handleSdlEvent(event);
    }
  }
}
