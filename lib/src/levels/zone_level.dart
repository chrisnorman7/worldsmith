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
import '../npcs/npc_context.dart';
import 'pause_menu.dart';
import 'walking_mode.dart';

const _origin = Point(0.0, 0.0);

/// A level for playing through a zone.
class ZoneLevel extends Level {
  /// Create an instance.
  ZoneLevel({
    required this.worldContext,
    required this.zone,
    final double initialHeading = 0.0,
    final Point<double> coordinates = _origin,
    this.walkingDirection = WalkingDirection.forwards,
    this.timeSinceLastWalked = 1000000,
  })  : _firstStepTaken = false,
        _slowWalk = false,
        _heading = initialHeading,
        _coordinates = coordinates,
        _coordinatesOffset = const Point(0, 0),
        _tiles = [],
        _objects = [],
        _end = const Point(0, 0),
        affectedInterfaceSounds = worldContext.game.createSoundChannel(),
        boxReverbs = {},
        currentTerrain = worldContext.world.getTerrain(zone.defaultTerrainId),
        zoneObjectSoundChannels = {},
        zoneObjectAmbiances = {},
        npcContexts = zone.npcs.map<NpcContext>(
          (final e) {
            final coordinates =
                zone.getAbsoluteCoordinates(e.initialCoordinates).toDouble();
            final channel = worldContext.game.createSoundChannel(
              position: SoundPosition3d(
                x: coordinates.x,
                y: coordinates.y,
                z: e.z,
              ),
            );
            final sound = e.ambiance;
            final ambiance = sound == null
                ? null
                : getAmbiance(
                    assets: worldContext.world.ambianceAssets,
                    sound: sound,
                  );
            return NpcContext(
              npc: e,
              coordinates: coordinates,
              channel: channel,
              ambiance: ambiance == null
                  ? null
                  : channel.playSound(
                      ambiance.sound,
                      gain: ambiance.gain,
                      keepAlive: true,
                      looping: true,
                    ),
            )..resetTimeUntilMove(
                random: worldContext.game.random,
                move: e.moves.isEmpty ? null : e.moves.first,
              );
          },
        ).toList(),
        super(
          game: worldContext.game,
          music: getMusic(
            assets: worldContext.world.musicAssets,
            sound: zone.music,
          ),
          ambiances: zone.ambiances
              .map(
                (final sound) => getAmbiance(
                  assets: worldContext.world.ambianceAssets,
                  sound: sound,
                ),
              )
              .toList(),
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
  set heading(final double value) {
    _heading = value % 360;
    game.setListenerOrientation(value);
  }

  /// The coordinates of the player.
  Point<double> _coordinates;

  /// Get the player's current coordinates.
  Point<double> get coordinates => _coordinates;

  /// Set the listener's position.
  set coordinates(final Point<double> value) {
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

  /// The NPC contexts to use.
  final List<NpcContext> npcContexts;

  /// Get a valid sound channel for the given [object].
  ///
  /// The sound channel will be created if it hasn't already.
  SoundChannel getZoneObjectSoundChannel(final ZoneObject object) {
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

  /// Stop all NPC sounds.
  void destroyNpcSounds() {
    while (npcContexts.isNotEmpty) {
      final context = npcContexts.removeLast();
      for (final sound in [
        context.ambiance,
        context.lastMovementSound,
        context.lastSound
      ]) {
        sound?.destroy();
      }
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
          ).reference,
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
  void setReverb(final Box? box) {
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
    var minCoordinates = const Point(0, 0);
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
  void onReveal(final Level old) {
    super.onReveal(old);
    resetState();
    final music = zone.music;
    final sound = musicSound;
    if (sound != null && music != null) {
      final fadeTime = zone.musicFadeTime;
      if (fadeTime == null) {
        sound.gain = music.gain;
      } else {
        sound.fade(
          length: fadeTime,
          endGain: music.gain,
          startGain: zone.musicFadeGain,
        );
      }
    }
    final ambianceFadeTime = zone.ambianceFadeTime;
    for (final ambiance in ambiances) {
      final sound = ambiancePlaybacks[ambiance]!.sound;
      if (ambianceFadeTime == null) {
        sound.gain = ambiance.gain;
      } else {
        sound.fade(
          length: ambianceFadeTime,
          endGain: ambiance.gain,
          startGain: zone.ambianceFadeGain,
        );
      }
    }
    for (final object in zone.objects) {
      final ambiance = object.ambiance;
      if (ambiance == null) {
        continue;
      }
      final sound = zoneObjectAmbiances[object.id]!.sound;
      if (ambianceFadeTime == null) {
        sound.gain = ambiance.gain;
      } else {
        sound.fade(
          length: ambianceFadeTime,
          endGain: ambiance.gain,
          startGain: zone.ambianceFadeGain,
        );
      }
    }
  }

  /// This zone has been covered, probably by a [PauseMenu] instance.
  @override
  void onCover(final Level other) {
    super.onCover(other);
    stopWalking();
    final music = zone.music;
    final sound = musicSound;
    if (sound != null && music != null) {
      final fadeTime = zone.musicFadeTime;
      if (fadeTime == null) {
        sound.gain = zone.musicFadeGain;
      } else {
        sound.fade(
          length: fadeTime,
          startGain: music.gain,
          endGain: zone.musicFadeGain,
        );
      }
    }
    final ambianceFadeTime = zone.ambianceFadeTime;
    for (final ambiance in ambiances) {
      final sound = ambiancePlaybacks[ambiance]!.sound;
      if (ambianceFadeTime == null) {
        sound.gain = zone.ambianceFadeGain;
      } else {
        sound.fade(
          length: ambianceFadeTime,
          startGain: ambiance.gain,
          endGain: zone.ambianceFadeGain,
        );
      }
    }
    for (final object in zone.objects) {
      final ambiance = object.ambiance;
      if (ambiance == null) {
        continue;
      }
      final sound = zoneObjectAmbiances[object.id]!.sound;
      if (ambianceFadeTime == null) {
        sound.gain = zone.ambianceFadeGain;
      } else {
        sound.fade(
          length: ambianceFadeTime,
          startGain: ambiance.gain,
          endGain: zone.ambianceFadeGain,
        );
      }
    }
  }

  /// Destroy all the created reverbs, and the sound channel.
  @override
  void onPop(final double? fadeLength) {
    super.onPop(fadeLength);
    while (boxReverbs.isNotEmpty) {
      boxReverbs.remove(boxReverbs.keys.first)!.destroy();
    }
    destroyZoneObjectSounds();
    destroyNpcSounds();
    affectedInterfaceSounds.destroy();
  }

  /// Get the reverb for the given [box].
  CreateReverb? getBoxReverb(final Box box) {
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
  void maybeWalk(final int timeDelta) {
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
    required final Point<double> destination,
    final bool updateLastWalked = true,
    final bool runWalkCommand = true,
  }) {
    final oldBox = getBox();
    final s = size;
    if (destination.x < 0 ||
        destination.y < 0 ||
        destination.x >= s.x ||
        destination.y >= s.y) {
      worldContext.onEdgeOfZoneLevel(this, destination);
      final edgeCommand = zone.edgeCommand;
      if (edgeCommand != null) {
        worldContext.handleCallCommand(
          callCommand: edgeCommand,
          replacements: {
            'zone_name': zone.name,
            'x': destination.x.toStringAsFixed(2),
            'y': destination.y.toStringAsFixed(2)
          },
        );
      }
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
          final leaveCommand = oldBox.leaveCommand;
          if (leaveCommand != null) {
            worldContext.handleCallCommand(
              callCommand: leaveCommand,
              replacements: {'box_name': oldBox.name},
            );
          }
        }
      } else {
        final enterCommand = newBox.enterCommand;
        if (enterCommand != null) {
          worldContext.handleCallCommand(
            callCommand: enterCommand,
            replacements: {'box_name': newBox.name},
          );
        }
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
      final walkCommand = newBox.walkCommand;
      if (runWalkCommand == true && walkCommand != null) {
        worldContext.handleCallCommand(callCommand: walkCommand);
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
        sound = terrain.fastWalk.sound;
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
      final collideCommand = object.collideCommand;
      if (collideCommand != null) {
        worldContext.handleCallCommand(callCommand: collideCommand);
      }
    }
    if (updateLastWalked) {
      timeSinceLastWalked = 0;
    }
    return newBox;
  }

  /// Walk a bit.
  Box? walk(final WalkingOptions options) {
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
      bearing,
      options.distance,
    );
    return moveTo(destination: destination);
  }

  /// Maybe walk.
  @override
  Future<void> tick(final Sdl sdl, final int timeDelta) async {
    super.tick(sdl, timeDelta);
    timeSinceLastWalked += timeDelta;
    maybeWalk(timeDelta);
    final turnModifier = turnAmount;
    if (turnModifier != null) {
      final degrees =
          turnModifier * worldContext.playerPreferences.turnSensitivity;
      if (degrees.abs() > 0) {
        heading += degrees;
      }
    }
    moveNpcs(timeDelta);
  }

  /// Handle SDL events.
  @override
  void handleSdlEvent(final Event event) {
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

  /// Move the NPC's identified by [npcContexts].
  void moveNpcs(final int timeDelta) {
    for (final context in npcContexts) {
      if (context.npc.moves.isNotEmpty) {
        context.timeUntilMove -= timeDelta;
        moveNpc(context, timeDelta);
      }
    }
  }

  /// Move the npc with the given [context].
  void moveNpc(final NpcContext context, final int timeDelta) {
    final world = worldContext.world;
    final npc = context.npc;
    var move = npc.moves[context.moveIndex];
    final marker = zone.getLocationMarker(move.locationMarkerId);
    final destination = zone.getAbsoluteCoordinates(marker.coordinates);
    var box = getBox(context.coordinates);
    var terrainId = box?.terrainId ?? zone.defaultTerrainId;
    var terrain = world.getTerrain(terrainId);
    final walkingOptions = move.walkingMode == WalkingMode.slow
        ? terrain.slowWalk
        : terrain.fastWalk;
    final stepSize = move.stepSize ?? walkingOptions.distance;
    var x = context.coordinates.x;
    var y = context.coordinates.y;
    if (destination.x > x) {
      x += min(stepSize, destination.x - x);
    } else {
      x -= min(stepSize, x - destination.x);
    }
    if (destination.y > y) {
      y += min(stepSize, destination.y - y);
    } else {
      y -= min(stepSize, y - destination.y);
    }
    final channel = context.channel;
    context.coordinates = Point(x, y);
    channel.position = SoundPosition3d(x: x, y: y, z: npc.z);
    box = getBox(context.coordinates);
    terrainId = box?.terrainId ?? zone.defaultTerrainId;
    terrain = world.getTerrain(terrainId);
    final moveCommand = move.moveCommand;
    final replacements = {
      'npc_name': npc.name,
      'box_name': box?.name ?? 'nowhere'
    };
    if (moveCommand != null) {
      worldContext.handleCallCommand(
        callCommand: moveCommand,
        replacements: replacements,
        soundChannel: channel,
        zoneLevel: this,
      );
    }
    if (x.floor() == destination.x && y.floor() == destination.y) {
      context.moveIndex++;
      if (context.moveIndex >= npc.moves.length) {
        context.moveIndex = 0;
        final endCommand = move.endCommand;
        if (endCommand != null) {
          worldContext.handleCallCommand(
            callCommand: endCommand,
            replacements: replacements,
            soundChannel: channel,
            zoneLevel: this,
          );
        }
        move = npc.moves[context.moveIndex];
        final startCommand = move.startCommand;
        if (startCommand != null) {
          worldContext.handleCallCommand(
            callCommand: startCommand,
            replacements: replacements,
            soundChannel: channel,
            zoneLevel: this,
          );
        }
      }
    }
    final Sound? sound;
    final moveSound = move.moveSound;
    if (moveSound != null) {
      sound = moveSound;
    } else {
      switch (move.walkingMode) {
        case WalkingMode.stationary:
          sound = null;
          break;
        case WalkingMode.slow:
          sound = terrain.slowWalk.sound;
          break;
        case WalkingMode.fast:
          sound = terrain.fastWalk.sound;
          break;
      }
    }
    if (sound != null) {
      context.lastMovementSound = channel.playSound(
        getAssetReferenceReference(assets: world.terrainAssets, id: sound.id)
            .reference,
        gain: sound.gain,
        keepAlive: true,
      );
    }
    context.resetTimeUntilMove(
      random: game.random,
      move: move,
    );
  }
}
