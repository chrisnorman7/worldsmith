/// Provides the [ZoneLevel] class.
import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:ziggurat/levels.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../command_triggers.dart';
import '../../constants.dart';
import '../../util.dart';
import '../../world_context.dart';
import '../json/options/walking_options.dart';
import '../json/sound.dart';
import '../json/zones/box.dart';
import '../json/zones/terrain.dart';
import '../json/zones/zone.dart';
import '../json/zones/zone_object.dart';
import 'walking_mode.dart';

const _origin = Point(0.0, 0.0);

/// A level for playing through a zone.
class ZoneLevel extends Level {
  /// Create an instance.
  ZoneLevel({
    required this.worldContext,
    required this.zone,
    double initialHeading = 0.0,
    Point<double> coordinates = _origin,
    this.walkingDirection = WalkingDirection.forwards,
    this.timeSinceLastWalked = 1000000,
  })  : _firstStepTaken = false,
        _slowWalk = false,
        _heading = initialHeading,
        _coordinates = coordinates,
        _coordinatesOffset = Point(0, 0),
        _tiles = [],
        _objects = [],
        _end = Point(0, 0),
        affectedInterfaceSounds = worldContext.game.createSoundChannel(),
        boxReverbs = {},
        currentTerrain = worldContext.world.getTerrain(zone.defaultTerrainId),
        zoneObjectSoundChannels = {},
        zoneObjectAmbiances = {},
        super(
          game: worldContext.game,
          music: getMusic(
            assets: worldContext.world.musicAssets,
            sound: zone.music,
          ),
          ambiances: [
            for (final ambiance in zone.ambiances)
              getAmbiance(
                assets: worldContext.world.ambianceAssets,
                sound: ambiance,
              )!
          ],
        );

  /// Set to `true` after the first step has been taken.
  bool _firstStepTaken;

  /// Whether or not to slow walk.
  bool _slowWalk;

  /// The world context to use.
  final WorldContext worldContext;

  /// The zone to use.
  final Zone zone;

  /// The direction the player is facing in.
  double _heading;

  /// Get the player's current heading.
  double get heading => _heading;

  /// Set the player's heading.
  set heading(double value) {
    _heading = value % 360;
    game.setListenerOrientation(value);
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

  /// The direction the player is walking in.
  WalkingDirection walkingDirection;

  /// The amount to add to the [heading] each [tick].
  double? turnAmount;

  /// The speed the player is currently walking at.
  WalkingMode get walkingMode {
    final terrain = currentTerrain;
    final options = currentWalkingOptions;
    if (options == terrain.fastWalk) {
      return WalkingMode.fast;
    } else if (options == terrain.slowWalk) {
      return WalkingMode.slow;
    } else {
      return WalkingMode.stationary;
    }
  }

  /// The number of milliseconds since the [walk] method was called.
  int timeSinceLastWalked;

  final List<List<String?>> _tiles;
  final List<List<String?>> _objects;

  /// The loaded tiles.
  List<List<String?>> get tiles => _tiles;

  /// The objects that have been loaded from the [zone].
  List<List<String?>> get objects => _objects;

  Point<int> _coordinatesOffset;

  /// The difference between the origin and the minimum coordinates from boxes.
  Point<int> get coordinatesOffset => _coordinatesOffset;
  Point<int> _end;

  /// The coordinates of the northeast-most point of this level.
  Point<int> get size => _end;

  /// The sound channels for all the [ZoneObject]s.
  final Map<String, SoundChannel> zoneObjectSoundChannels;

  /// The zone object ambiances that are playing.
  final Map<String, SoundPlayback> zoneObjectAmbiances;

  /// Get a valid sound channel for the given [object].
  ///
  /// The sound channel will be created if it hasn't already.
  SoundChannel getZoneObjectSoundChannel(ZoneObject object) {
    final coordinates = zone
        .getAbsoluteCoordinates(
          object.initialCoordinates,
        )
        .toDouble();
    final soundChannel = zoneObjectSoundChannels[object.id];
    if (soundChannel != null) {
      soundChannel.position = SoundPosition3d(
        x: coordinates.x,
        y: coordinates.y,
      );
      return soundChannel;
    }
    final box = getBox(coordinates);
    final reverb = box == null ? null : getBoxReverb(box);
    final channel = game.createSoundChannel(
      gain: worldContext.world.soundOptions.defaultGain,
      reverb: reverb,
      position: SoundPosition3d(
        x: coordinates.x,
        y: coordinates.y,
      ),
    );
    zoneObjectSoundChannels[object.id] = channel;
    return channel;
  }

  /// Destroy every channel in [zoneObjectSoundChannels].
  void destroyZoneObjectSounds() {
    for (final object in zone.objects) {
      zoneObjectSoundChannels.remove(object.id)?.destroy();
      zoneObjectAmbiances.remove(object.id)?.sound.destroy();
    }
  }

  /// Start all zone object ambiances playing.
  void playZoneObjectAmbiances() {
    for (final object in zone.objects) {
      final ambiance = object.ambiance;
      if (ambiance != null) {
        final channel = getZoneObjectSoundChannel(object);
        final sound = channel.playSound(
          getAssetReferenceReference(
            assets: worldContext.world.ambianceAssets,
            id: ambiance.id,
          )!
              .reference,
          gain: ambiance.gain,
          keepAlive: true,
          looping: true,
        );
        zoneObjectAmbiances[object.id] = SoundPlayback(channel, sound);
      }
    }
  }

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

  /// Get the box that resides at the provided coordinates.
  ///
  /// If the coordinates are out of range, [RangeError] will be thrown.
  Box? getBox([Point<double>? where]) {
    where ??= _coordinates;
    final id = _tiles[where.x.floor()][where.y.floor()];
    if (id == null) {
      return null;
    }
    return zone.getBox(id);
  }

  /// Get the zone object at the given position.
  ZoneObject? getZoneObject([Point<double>? where]) {
    where ??= coordinates;
    final objectId = _objects[where.x.floor()][where.y.floor()];
    if (objectId != null) {
      return zone.getZoneObject(objectId);
    }
    return null;
  }

  /// Show the current coordinates.
  void showCoordinates() {
    final x = coordinates.x.floor();
    final y = coordinates.y.floor();
    game.outputText('$x, $y');
  }

  /// Show the facing direction.
  void showFacing() {
    final facing = heading.floor();
    final direction = worldContext.getDirectionName(facing);
    game.outputText('$direction ($facing degrees)');
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
          walkingDirection = WalkingDirection.forwards;
          startWalking();
        },
        onStop: stopWalking,
      ),
    );
    registerCommand(
      walkBackwardsCommandTrigger.name,
      Command(
        onStart: () {
          walkingDirection = WalkingDirection.backwards;
          startWalking();
        },
        onStop: stopWalking,
      ),
    );
    registerCommand(
      sidestepLeftCommandTrigger.name,
      Command(
        onStart: () {
          walkingDirection = WalkingDirection.left;
          startWalking();
        },
        onStop: stopWalking,
      ),
    );
    registerCommand(
      sidestepRightCommandTrigger.name,
      Command(
        onStart: () {
          walkingDirection = WalkingDirection.right;
          startWalking();
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
          }
        },
        onStop: () {
          _slowWalk = false;
          if (currentWalkingOptions != null) {
            currentWalkingOptions = currentTerrain.fastWalk;
          }
        },
      ),
    );
    registerCommand(
      turnLeftCommandTrigger.name,
      Command(
        onStart: () {
          heading = heading - zone.turnAmount;
        },
      ),
    );
    registerCommand(
      turnRightCommandTrigger.name,
      Command(
        onStart: () {
          heading = heading + zone.turnAmount;
        },
      ),
    );
    var minCoordinates = Point(0, 0);
    final startCoordinates = <String, Point<int>>{};
    final endCoordinates = <String, Point<int>>{};
    // First pass: Get the minimum and maximum coordinates.
    for (final box in zone.boxes) {
      final start = zone.getAbsoluteCoordinates(box.start);
      startCoordinates[box.id] = start;
      final end = zone.getAbsoluteCoordinates(box.end);
      endCoordinates[box.id] = end;
      minCoordinates = Point(
        min(minCoordinates.x, start.x),
        min(minCoordinates.y, start.y),
      );
      _end = Point(
        max(_end.x, end.x),
        max(_end.y, end.y),
      );
    }
    _coordinatesOffset = Point(
      minCoordinates.x < 0 ? minCoordinates.x * -1 : 0,
      minCoordinates.y < 0 ? minCoordinates.y * -1 : 0,
    );
    _end = Point(
      _end.x + coordinatesOffset.x + 1,
      _end.y + coordinatesOffset.y + 1,
    );
    // Null all the tiles and objects.
    _tiles.clear();
    _objects.clear();
    for (var i = 0; i < (_end.x + 1); i++) {
      _tiles.add(
        List<String?>.filled(
          _end.y + 1,
          null,
        ),
      );
      _objects.add(
        List<String?>.filled(
          _end.y + 1,
          null,
        ),
      );
    }
    // Second pass: Change `null` to box indices.
    for (final box in zone.boxes) {
      final start = startCoordinates[box.id]!;
      final end = endCoordinates[box.id]!;
      for (var x = start.x + coordinatesOffset.x;
          x <= end.x + coordinatesOffset.x;
          x++) {
        for (var y = start.y + coordinatesOffset.y;
            y <= end.y + coordinatesOffset.y;
            y++) {
          _tiles[x][y] = box.id;
        }
      }
    }
    // Load all objects.
    for (final object in zone.objects) {
      final objectCoordinates = zone.getAbsoluteCoordinates(
        object.initialCoordinates,
      );
      _objects[objectCoordinates.x][objectCoordinates.y] = object.id;
    }
    final box = getBox();
    if (box != null) {
      currentTerrain = worldContext.world.getTerrain(box.terrainId);
    }
    playZoneObjectAmbiances();
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
    destroyZoneObjectSounds();
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

  /// Start walking if the time is right.
  void maybeWalk(int timeDelta) {
    final walkingOptions = currentWalkingOptions;
    if (walkingOptions != null) {
      if (timeSinceLastWalked >= walkingOptions.interval) {
        walk(walkingOptions);
      }
    }
  }

  /// Start walking.
  void startWalking() {
    if (_slowWalk) {
      currentWalkingOptions = currentTerrain.slowWalk;
    } else {
      currentWalkingOptions = currentTerrain.fastWalk;
    }
    maybeWalk(0);
  }

  /// Stop walking.
  void stopWalking() {
    walkingDirection = WalkingDirection.forwards;
    currentWalkingOptions = null;
  }

  /// Move directly to the given [destination].
  Box? moveTo({
    required Point<double> destination,
    bool updateLastWalked = true,
    bool runWalkCommand = true,
  }) {
    final oldBox = getBox();
    final s = size;
    if (destination.x < 0 ||
        destination.y < 0 ||
        destination.x >= s.x ||
        destination.y >= s.y) {
      worldContext
        ..onEdgeOfZoneLevel(this, destination)
        ..runCallCommand(
          callCommand: zone.edgeCommand,
          replacements: {
            'zone_name': zone.name,
            'x': destination.x.toStringAsFixed(2),
            'y': destination.y.toStringAsFixed(2)
          },
        );
      if (updateLastWalked) {
        timeSinceLastWalked = 0;
      }
      return oldBox;
    }
    final newBox = getBox(destination);
    if (newBox?.id != oldBox?.id) {
      _firstStepTaken = true;
      // Boxes are different.
      setReverb(newBox);
      if (newBox == null) {
        if (oldBox != null) {
          worldContext.runCallCommand(
            callCommand: oldBox.leaveCommand,
            replacements: {'box_name': oldBox.name},
          );
        }
      } else {
        worldContext.runCallCommand(
          callCommand: newBox.enterCommand,
          replacements: {'box_name': newBox.name},
        );
      }
    }
    if (_firstStepTaken == false) {
      setReverb(newBox);
    }
    final Terrain terrain;
    if (newBox == null) {
      terrain = worldContext.world.getTerrain(zone.defaultTerrainId);
    } else {
      terrain = worldContext.world.getTerrain(newBox.terrainId);
      if (runWalkCommand == true) {
        worldContext.runCallCommand(callCommand: newBox.walkCommand);
      }
    }
    currentTerrain = terrain;
    Sound? sound;
    if (currentWalkingOptions == null) {
      currentWalkingOptions = null;
    } else {
      if (_slowWalk == true) {
        sound = terrain.slowWalk.sound;
        currentWalkingOptions = terrain.slowWalk;
      } else {
        sound = terrain.slowWalk.sound;
        currentWalkingOptions = terrain.fastWalk;
      }
    }
    if (sound != null) {
      playSound(
        channel: affectedInterfaceSounds,
        sound: sound,
        assets: worldContext.world.terrainAssets,
      );
    }
    coordinates = destination;
    final object = getZoneObject();
    if (object != null) {
      worldContext.runCallCommand(callCommand: object.collideCommand);
    }
    if (updateLastWalked) {
      timeSinceLastWalked = 0;
    }
    return newBox;
  }

  /// Walk a bit.
  Box? walk(WalkingOptions options) {
    final double bearing;
    switch (walkingDirection) {
      case WalkingDirection.forwards:
        bearing = heading;
        break;
      case WalkingDirection.backwards:
        bearing = (heading + 180) % 360;
        break;
      case WalkingDirection.left:
        bearing = (heading - 90) % 360;
        break;
      case WalkingDirection.right:
        bearing = (heading + 90) % 360;
        break;
    }
    final destination = coordinatesInDirection(
      _coordinates,
      bearing.toDouble(),
      options.distance,
    );
    return moveTo(destination: destination);
  }

  /// Maybe walk.
  @override
  Future<void> tick(Sdl sdl, int timeDelta) async {
    super.tick(sdl, timeDelta);
    timeSinceLastWalked += timeDelta;
    maybeWalk(timeDelta);
    final turnModifier = turnAmount;
    if (turnModifier != null) {
      final degrees = turnModifier * 3;
      if (degrees.abs() > 0) {
        heading += degrees;
      }
    }
  }

  /// Handle SDL events.
  @override
  void handleSdlEvent(Event event) {
    if (event is ControllerAxisEvent) {
      if (event.axis == GameControllerAxis.lefty) {
        var value = event.smallValue;
        if (value < 0) {
          walkingDirection = WalkingDirection.forwards;
          value = event.smallValue * -1;
        } else {
          walkingDirection = WalkingDirection.backwards;
        }
        final terrain = currentTerrain;
        if (value >= terrain.fastWalk.joystickValue) {
          currentWalkingOptions = terrain.fastWalk;
          _slowWalk = false;
        } else if (value >= terrain.slowWalk.joystickValue) {
          currentWalkingOptions = terrain.slowWalk;
          _slowWalk = true;
        } else {
          stopWalking();
        }
      } else if (event.axis == GameControllerAxis.rightx) {
        final value = event.smallValue;
        if (value.abs() >= 0.1) {
          turnAmount = value;
        } else {
          turnAmount = null;
        }
      }
    } else {
      super.handleSdlEvent(event);
    }
  }
}
