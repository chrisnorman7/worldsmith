/// Provides the [ZoneLevel] class.
import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:ziggurat/levels.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../command_triggers.dart';
import '../../util.dart';
import '../../world_context.dart';
import '../json/messages/custom_message.dart';
import '../json/options/walking_options.dart';
import '../json/sound.dart';
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
    this.timeSinceLastWalked = 1000000,
  })  : _firstStepTaken = false,
        _slowWalk = false,
        _heading = heading,
        _coordinates = coordinates,
        affectedInterfaceSounds = worldContext.game.createSoundChannel(),
        boxReverbs = {},
        currentTerrain = worldContext.world.getTerrain(zone.defaultTerrainId),
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
    registerCommand(
      pauseMenuCommandTrigger.name,
      Command(
        onStart: () => game.pushLevel(
          worldContext.getPauseMenu(zone),
        ),
      ),
    );
    registerCommand(
      showCoordinatesCommandTrigger.name,
      Command(
        onStart: showCoordinates,
      ),
    );
    registerCommand(
      showFacingCommandTrigger.name,
      Command(
        onStart: showFacing,
      ),
    );
    registerCommand(
      walkForwardsCommandTrigger.name,
      Command(
        onStart: () {
          if (_slowWalk) {
            currentWalkingOptions = currentTerrain.slowWalk;
            walkingMode = WalkingMode.slow;
          } else {
            currentWalkingOptions = currentTerrain.fastWalk;
            walkingMode = WalkingMode.fast;
          }
        },
        onStop: stopWalking,
      ),
    );
    registerCommand(
      slowWalkCommandTrigger.name,
      Command(
        onStart: () {
          _slowWalk = true;
          if (currentWalkingOptions != null) {
            currentWalkingOptions = currentTerrain.slowWalk;
            walkingMode = WalkingMode.slow;
          }
        },
        onStop: () {
          _slowWalk = false;
          if (currentWalkingOptions != null) {
            currentWalkingOptions = currentTerrain.fastWalk;
            walkingMode = WalkingMode.fast;
          }
        },
      ),
    );
    registerCommand(
      turnLeftCommandTrigger.name,
      Command(
        onStart: () => heading -= zone.turnAmount,
      ),
    );
    registerCommand(
      turnRightCommandTrigger.name,
      Command(
        onStart: () => heading += zone.turnAmount,
      ),
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
      maxCoordinates.x + coordinatesOffset.x + 1,
      (x) => List<String?>.filled(
        maxCoordinates.y + coordinatesOffset.y + 1,
        null,
      ),
      growable: false,
    );
    // Second pass: Change `null` to box indices.
    for (final box in zone.boxes) {
      final start = zone.getAbsoluteCoordinates(box.start);
      final end = zone.getAbsoluteCoordinates(box.end);
      for (var x = start.x + coordinatesOffset.x;
          x <= end.x + coordinatesOffset.x;
          x++) {
        for (var y = start.y + coordinatesOffset.y;
            y <= end.y + coordinatesOffset.y;
            y++) {
          tiles[x][y] = box.id;
        }
      }
    }
    final box = getBox();
    if (box != null) {
      currentTerrain = worldContext.world.getTerrain(box.terrainId);
    }
  }

  /// Stop walking.
  void stopWalking() {
    currentWalkingOptions = null;
    walkingMode = WalkingMode.stationary;
    timeSinceLastWalked = 1000000;
  }

  /// Set to `true` after the first step has been taken.
  bool _firstStepTaken;

  /// Whether or not to slow walk.
  bool _slowWalk;

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

  /// The current terrain.
  Terrain currentTerrain;

  /// The current walking options.
  WalkingOptions? currentWalkingOptions;

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

  /// Set the reverb for the [affectedInterfaceSounds].
  ///
  /// If the provided [box] is `null`, then the reverb will be null.
  /// Otherwise, the reverb preset from the [box] will be used.
  void setReverb(Box? box) {
    if (box == null) {
      if (affectedInterfaceSounds.reverb != null) {
        affectedInterfaceSounds.reverb = null;
      }
    } else {
      final reverb = getBoxReverb(box);
      affectedInterfaceSounds.reverb = reverb?.id;
    }
  }

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

  /// Show the current coordinates.
  void showCoordinates() {
    final x = coordinates.x.floor();
    final y = coordinates.y.floor();
    game.outputText('$x, $y');
  }

  /// Get the nearest direction.
  String getDirectionName([int? bearing]) {
    bearing ??= heading;
    String? direction;
    int? difference;
    for (final entry in worldContext.world.directions.entries) {
      final value = entry.value.floor();
      final d = max<int>(bearing, value) - min<int>(bearing, value);
      if (difference == null || difference > d) {
        difference = d;
        direction = entry.key;
      }
    }
    return direction ?? 'Unknown';
  }

  /// Show the facing direction.
  void showFacing() {
    game.outputText('${getDirectionName()} ($heading degrees.');
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
  CreateReverb? getBoxReverb(Box box) {
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

  /// Move directly to the given [destination].
  Box? moveTo({
    required Point<double> destination,
    bool updateLastWalked = true,
  }) {
    final oldBox = getBox();
    final s = size;
    if (destination.x < 0 ||
        destination.y < 0 ||
        destination.x >= s.x ||
        destination.y >= s.y) {
      worldContext.onEdgeOfZoneLevel(this, destination);
      final message = zone.edgeMessage;
      game.outputMessage(
        worldContext.getCustomMessage(message),
        soundChannel: affectedInterfaceSounds,
      );
      return oldBox;
    }
    final newBox = getBox(destination);
    if (newBox?.id != oldBox?.id) {
      _firstStepTaken = true;
      // Boxes are different.
      setReverb(newBox);
      final CustomMessage message;
      if (newBox == null) {
        if (oldBox != null) {
          message = oldBox.leaveMessage;
        } else {
          message = CustomMessage(
            text: "Both boxes are null, and the compiler somehow doesn't know "
                'that.',
          );
        }
      } else {
        message = newBox.enterMessage;
      }
      game.outputMessage(worldContext.getCustomMessage(message));
    }
    if (_firstStepTaken == false) {
      setReverb(newBox);
    }
    final Terrain terrain;
    if (newBox == null) {
      terrain = worldContext.world.getTerrain(zone.defaultTerrainId);
    } else {
      terrain = worldContext.world.getTerrain(newBox.terrainId);
    }
    currentTerrain = terrain;
    Sound? sound;
    switch (walkingMode) {
      case WalkingMode.stationary:
        currentWalkingOptions = null;
        break;
      case WalkingMode.slow:
        sound = terrain.slowWalk.sound;
        currentWalkingOptions = terrain.slowWalk;
        break;
      case WalkingMode.fast:
        sound = terrain.slowWalk.sound;
        currentWalkingOptions = terrain.fastWalk;
        break;
    }
    if (sound != null) {
      playSound(
        channel: affectedInterfaceSounds,
        sound: sound,
        assets: worldContext.world.terrainAssets,
      );
    }
    coordinates = destination;
    if (updateLastWalked) {
      timeSinceLastWalked = 0;
    }
    return newBox;
  }

  /// Walk a bit.
  Box? walk(WalkingOptions options) {
    final destination = coordinatesInDirection(
      _coordinates,
      _heading.toDouble(),
      options.distance,
    );
    return moveTo(destination: destination);
  }

  /// Maybe walk.
  @override
  Future<void> tick(Sdl sdl, int timeDelta) async {
    super.tick(sdl, timeDelta);
    final walkingOptions = currentWalkingOptions;
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
        final value = event.smallValue * -1;
        if (value > 0) {
          if (value >= currentTerrain.fastWalk.joystickValue) {
            walkingMode = WalkingMode.fast;
            currentWalkingOptions = currentTerrain.fastWalk;
          } else if (value >= currentTerrain.slowWalk.joystickValue) {
            walkingMode = WalkingMode.slow;
            currentWalkingOptions = currentTerrain.slowWalk;
          } else {
            stopWalking();
          }
        }
      }
    } else {
      super.handleSdlEvent(event);
    }
  }
}
