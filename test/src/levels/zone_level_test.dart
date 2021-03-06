import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:test/test.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import '../../custom_game.dart';
import '../../pond_zone.dart';

void main() {
  group(
    'ZoneLevel class',
    () {
      final sdl = Sdl();
      const ambiance1Asset = AssetReference.file('ambiance1.mp3');
      const ambiance2Asset = AssetReference.file('ambiance2.mp3');
      const ambiance1Reference = AssetReferenceReference(
        variableName: 'ambiance1',
        reference: ambiance1Asset,
      );
      const ambiance2Reference = AssetReferenceReference(
        variableName: 'ambiance2',
        reference: ambiance2Asset,
      );
      final ambiance1 = Sound(
        id: ambiance1Reference.variableName,
        gain: 1.0,
      );
      final ambiance2 = Sound(
        id: ambiance2Reference.variableName,
        gain: 2.0,
      );
      const slowWalkReference = AssetReferenceReference(
        variableName: 'slow_walk',
        reference: AssetReference.file('slow_walk.mp3'),
      );
      const fastWalkReference = AssetReferenceReference(
        variableName: 'fast_walk',
        reference: AssetReference.file('fast_walk.mp3'),
      );
      final defaultTerrain = Terrain(
        id: 'terrain',
        name: 'Default Terrain',
        slowWalk: WalkingOptions(
          interval: 500,
          sound: Sound(id: slowWalkReference.variableName),
        ),
        fastWalk: WalkingOptions(
          interval: 400,
          sound: Sound(id: fastWalkReference.variableName),
        ),
      );
      const musicAsset = AssetReference.file('music.mp3');
      const musicReference = AssetReferenceReference(
        variableName: 'music',
        reference: musicAsset,
        comment: 'Level music',
      );
      final music = Sound(id: musicReference.variableName, gain: 2.0);
      final pondZone = PondZone.generate();
      final world = World(
        terrainAssets: [slowWalkReference, fastWalkReference],
        terrains: [defaultTerrain],
        ambianceAssets: [ambiance1Reference, ambiance2Reference],
        musicAssets: [musicReference],
      );
      final game = CustomGame(
        title: world.title,
        sdl: sdl,
      );
      final worldContext = WorldContext(
        game: game,
        world: world,
      );
      pondZone.generateTerrains(world);
      final pondZoneLevel =
          ZoneLevel(worldContext: worldContext, zone: pondZone.zone)..onPush();
      test(
        'Initialisation',
        () {
          expect(pondZoneLevel.coordinates, const Point(0.0, 0.0));
          expect(pondZoneLevel.coordinatesOffset, const Point(2, 2));
          expect(pondZoneLevel.heading, isZero);
          expect(pondZoneLevel.tiles.length, pondZoneLevel.size.x + 1);
          expect(pondZoneLevel.tiles.first.length, pondZoneLevel.size.y + 1);
        },
      );
      test(
        'getBox',
        () {
          expect(pondZoneLevel.getBox(), pondZone.westBank);
          final point =
              pondZone.zone.getAbsoluteCoordinates(pondZone.pondBox.start);
          expect(
            pondZoneLevel.getBox(
              Point(
                point.x + pondZoneLevel.coordinatesOffset.x.toDouble(),
                point.y + pondZoneLevel.coordinatesOffset.y.toDouble(),
              ),
            ),
            pondZone.pondBox,
          );
        },
      );
      test(
        '.showCoordinates',
        () {
          game.strings.clear();
          pondZoneLevel.showCoordinates();
          expect(game.strings.length, 1);
          expect(game.strings.first, '0, 0');
          pondZoneLevel
            ..coordinates = const Point(pi, 15.54321)
            ..showCoordinates();
          expect(game.strings.length, 2);
          expect(game.strings.last, '3, 15');
        },
      );
      test(
        'showFacing',
        () {
          game.strings.clear();
          pondZoneLevel.showFacing();
          expect(game.strings.length, 1);
          expect(game.strings.first, 'North (0 degrees)');
          pondZoneLevel
            ..heading = 45
            ..showFacing();
          expect(game.strings.length, 2);
          expect(game.strings.last, 'Northeast (45 degrees)');
          pondZoneLevel
            ..heading = 52
            ..showFacing();
          expect(game.strings.length, 3);
          expect(game.strings.last, 'Northeast (52 degrees)');
          pondZoneLevel
            ..heading = 359
            ..showFacing();
          expect(game.strings.last, 'Northwest (359 degrees)');
        },
      );
      test(
        '.size',
        () {
          final end = pondZone.zone.getAbsoluteCoordinates(
            pondZone.eastBank.end,
          );
          final expected = Point(
            end.x + pondZoneLevel.coordinatesOffset.x + 1,
            end.y + pondZoneLevel.coordinatesOffset.y + 1,
          );
          expect(
            pondZoneLevel.size,
            expected,
          );
          expect(
            () => pondZoneLevel.getBox(
              Point(
                expected.x.toDouble() + 1,
                expected.y.toDouble() + 1,
              ),
            ),
            throwsA(isA<RangeError>()),
          );
        },
      );
      test(
        'Music',
        () {
          final zone = Zone(
            id: 'zone',
            name: 'Test Zone',
            boxes: [],
            music: music,
            defaultTerrainId: defaultTerrain.id,
          );
          world.zones.add(zone);
          final zoneLevel = ZoneLevel(worldContext: worldContext, zone: zone);
          expect(zoneLevel.ambiances.length, isZero);
          expect(zoneLevel.music, isNotNull);
          final levelMusic = zoneLevel.music;
          expect(levelMusic?.gain, music.gain);
          expect(levelMusic?.sound, musicAsset);
        },
      );
      test(
        '.ambiances',
        () {
          final zone = Zone(
            id: 'zone_with_ambiances',
            name: 'Zone With Ambiances',
            boxes: [],
            defaultTerrainId: defaultTerrain.id,
            ambiances: [ambiance1, ambiance2],
          );
          final zoneLevel = ZoneLevel(worldContext: worldContext, zone: zone);
          expect(zoneLevel.ambiances.length, 2);
          final ambiance1Ambiance = zoneLevel.ambiances.first;
          expect(ambiance1Ambiance.gain, ambiance1.gain);
          expect(ambiance1Ambiance.position, isNull);
          expect(ambiance1Ambiance.sound, ambiance1Asset);
          final ambiance2Ambiance = zoneLevel.ambiances.last;
          expect(ambiance2Ambiance.gain, ambiance2.gain);
          expect(ambiance2Ambiance.position, isNull);
          expect(ambiance2Ambiance.sound, ambiance2Asset);
        },
      );
    },
  );
  group(
    'Npcs',
    () {
      const slowWalkInterval = 500;
      const fastWalkInterval = 200;
      final defaultTerrain = Terrain(
        id: 'default',
        name: 'Default Terrain',
        slowWalk: WalkingOptions(interval: slowWalkInterval),
        fastWalk: WalkingOptions(interval: fastWalkInterval),
      );
      final grass = Terrain(
        id: 'grass',
        name: 'Grass',
        slowWalk: WalkingOptions(interval: slowWalkInterval),
        fastWalk: WalkingOptions(interval: fastWalkInterval),
      );
      final water = Terrain(
        id: 'water',
        name: 'Water',
        slowWalk: WalkingOptions(interval: slowWalkInterval),
        fastWalk: WalkingOptions(interval: fastWalkInterval),
      );
      final dirt = Terrain(
        id: 'dirt',
        name: 'Dirt',
        slowWalk: WalkingOptions(interval: slowWalkInterval),
        fastWalk: WalkingOptions(interval: fastWalkInterval),
      );
      final sand = Terrain(
        id: 'sand',
        name: 'Sand',
        slowWalk: WalkingOptions(interval: slowWalkInterval),
        fastWalk: WalkingOptions(interval: fastWalkInterval),
      );
      const boxSize = 5;
      final sw = Box(
        id: 'sw',
        name: 'Southwest',
        start: Coordinates(0, 0),
        end: Coordinates(boxSize, boxSize),
        terrainId: grass.id,
      );
      final nw = Box(
        id: 'nw',
        name: 'Northwest',
        start: Coordinates(
          0,
          1,
          clamp: CoordinateClamp(boxId: sw.id, corner: BoxCorner.northwest),
        ),
        end: Coordinates(
          0,
          boxSize + 1,
          clamp: CoordinateClamp(
            boxId: sw.id,
            corner: BoxCorner.northeast,
          ),
        ),
        terrainId: water.id,
      );
      final ne = Box(
        id: 'ne',
        name: 'Northeast',
        start: Coordinates(
          1,
          1,
          clamp: CoordinateClamp(
            boxId: sw.id,
            corner: BoxCorner.northeast,
          ),
        ),
        end: Coordinates(
          boxSize + 1,
          boxSize + 1,
          clamp: CoordinateClamp(
            boxId: sw.id,
            corner: BoxCorner.northeast,
          ),
        ),
        terrainId: dirt.id,
      );
      final se = Box(
        id: 'se',
        name: 'Southeast',
        start: Coordinates(
          1,
          0,
          clamp: CoordinateClamp(
            boxId: sw.id,
            corner: BoxCorner.southeast,
          ),
        ),
        end: Coordinates(
          0,
          -1,
          clamp: CoordinateClamp(
            boxId: ne.id,
            corner: BoxCorner.southeast,
          ),
        ),
        terrainId: sand.id,
      );
      final zone = Zone(
        id: 'zone',
        name: 'Zone',
        boxes: [sw, se, nw, ne],
        defaultTerrainId: defaultTerrain.id,
      );
      // Let's make sure the boxes are setup correctly.
      test(
        'Southwest Box',
        () {
          expect(zone.getAbsoluteCoordinates(sw.start), const Point(0, 0));
          expect(
            zone.getAbsoluteCoordinates(sw.end),
            const Point(boxSize, boxSize),
          );
        },
      );
      test(
        'Northwest Box',
        () {
          expect(
            zone.getAbsoluteCoordinates(nw.start),
            const Point(0, boxSize + 1),
          );
          expect(
            zone.getAbsoluteCoordinates(nw.end),
            const Point(boxSize, boxSize + 1 + boxSize),
          );
        },
      );
      test(
        'Northeast Box',
        () {
          expect(
            zone.getAbsoluteCoordinates(ne.start),
            const Point(boxSize + 1, boxSize + 1),
          );
          expect(
            zone.getAbsoluteCoordinates(ne.end),
            const Point(boxSize + 1 + boxSize, boxSize + 1 + boxSize),
          );
        },
      );
      test(
        'Southeast Box',
        () {
          expect(
            zone.getAbsoluteCoordinates(se.start),
            const Point(boxSize + 1, 0),
          );
          expect(
            zone.getAbsoluteCoordinates(se.end),
            const Point(boxSize + 1 + boxSize, boxSize),
          );
        },
      );
      final swMarker = LocationMarker(
        id: 'startMarker',
        name: 'Southwest Marker',
        coordinates: Coordinates(
          0,
          0,
          clamp: CoordinateClamp(
            boxId: sw.id,
            corner: BoxCorner.southwest,
          ),
        ),
      );
      test(
        'Southwest Marker',
        () {
          expect(
            zone.getAbsoluteCoordinates(swMarker.coordinates),
            const Point(0, 0),
          );
        },
      );
      final nwMarker = LocationMarker(
        id: 'nw',
        name: 'Northwest Marker',
        coordinates: Coordinates(
          0,
          0,
          clamp: CoordinateClamp(
            boxId: nw.id,
            corner: BoxCorner.northwest,
          ),
        ),
      );
      test(
        'Northwest Marker',
        () {
          expect(
            zone.getAbsoluteCoordinates(nwMarker.coordinates),
            zone.getBoxNorthwestCorner(nw),
          );
        },
      );
      final middleMarker = LocationMarker(
        id: 'middle',
        name: 'Middle Marker',
        coordinates: Coordinates(
          0,
          0,
          clamp: CoordinateClamp(
            boxId: ne.id,
            corner: BoxCorner.southwest,
          ),
        ),
      );
      zone.locationMarkers.addAll([swMarker, nwMarker, middleMarker]);
      test(
        'Middle Marker',
        () {
          expect(
            zone.getAbsoluteCoordinates(middleMarker.coordinates),
            zone.getAbsoluteCoordinates(ne.start),
          );
        },
      );
      final walker = Npc(
        id: 'walker',
        stats: const Statistics(defaultStats: {}, currentStats: {}),
        name: 'Walker',
      );
      // Link the NPC to the zone.
      final zoneNpc = ZoneNpc(
        npcId: walker.id,
        initialCoordinates: Coordinates(1, 1),
        moves: [
          NpcMove(
            id: 'nw',
            locationMarkerId: nwMarker.id,
            z: 1.0,
          ),
          NpcMove(
            id: 'middle',
            locationMarkerId: middleMarker.id,
            stepSize: 1.0,
            z: 2.0,
          ),
          NpcMove(
            id: 'sw',
            locationMarkerId: swMarker.id,
            z: 3.0,
          )
        ],
      );
      zone.npcs.add(zoneNpc);
      final world = World(
        npcs: [walker],
        terrains: [defaultTerrain, grass, water, dirt, sand],
        zones: [zone],
      );
      final sdl = Sdl();
      final worldContext = WorldContext(
        game: Game(
          title: 'NPC Tests',
          sdl: sdl,
        ),
        world: world,
        customCommands: {},
      );
      final level = worldContext.getZoneLevel(zone)..onPush();
      test(
        'Level',
        () {
          expect(level.zone, zone);
          expect(level.npcContexts.length, 1);
        },
      );
      final context = level.npcContexts.first;
      test(
        'Context',
        () {
          expect(context.zoneNpc, zoneNpc);
          expect(context.ambiance, isNull);
          expect(
            context.channel.position,
            predicate(
              (final value) =>
                  value is SoundPosition3d &&
                  value.x == context.coordinates.x &&
                  value.y == context.coordinates.y &&
                  value.z == 0,
            ),
          );
          expect(context.coordinates, const Point(1.0, 1.0));
          expect(context.lastMovementSound, isNull);
          expect(() => context.move, throwsStateError);
          expect(context.lastSound, isNull);
          expect(context.moveIndex, isNull);
          expect(
            context.timeUntilMove,
            isZero,
          );
        },
      );
      test(
        'Move NPC',
        () async {
          await level.tick(1);
          expect(context.moveIndex, isZero);
          expect(context.move, zoneNpc.moves.first);
          final timeUntilMove = context.timeUntilMove;
          expect(
            timeUntilMove,
            inInclusiveRange(
              zoneNpc.moves.first.minMoveInterval,
              zoneNpc.moves.first.maxMoveInterval,
            ),
          );
          final channel = context.channel;
          var position = channel.position as SoundPosition3d;
          await expectLater(
            Stream.fromIterable(
              [position.x, position.y, position.z],
            ),
            emitsInOrder(<Object>[1.0, 1.0, isZero]),
          );
          await level.tick(1);
          expect(context.move, zoneNpc.moves.first);
          expect(context.timeUntilMove, timeUntilMove - 1);
          expect(context.coordinates, const Point(1.0, 1.0));
          position = channel.position as SoundPosition3d;
          await expectLater(
            Stream.fromIterable(
              [position.x, position.y, position.z],
            ),
            emitsInOrder(<Object>[1.0, 1.0, isZero]),
          );
          await level.tick(timeUntilMove);
          expect(
            context.coordinates,
            Point(grass.fastWalk.distance, 1 + grass.fastWalk.distance),
          );
          position = channel.position as SoundPosition3d;
          await expectLater(
            Stream.fromIterable([position.x, position.y, position.z]),
            emitsInOrder(
              <Object>[
                grass.fastWalk.distance,
                1 + grass.fastWalk.distance,
                context.move.z
              ],
            ),
          );
          await level.tick(1);
          expect(
            context.coordinates,
            Point(grass.fastWalk.distance, 1 + grass.fastWalk.distance),
          );
          position = channel.position as SoundPosition3d;
          await expectLater(
            Stream.fromIterable([position.x, position.y, position.z]),
            emitsInOrder(
              <Object>[
                grass.fastWalk.distance,
                1 + grass.fastWalk.distance,
                context.move.z
              ],
            ),
          );
          final coordinates = zone.getAbsoluteCoordinates(nwMarker.coordinates);
          context.coordinates = Point(
            coordinates.x.toDouble(),
            coordinates.y - grass.fastWalk.distance,
          );
          final oldMove = context.move;
          await level.tick(context.timeUntilMove);
          expect(
            context.coordinates,
            Point(coordinates.x.toDouble(), coordinates.y.toDouble()),
          );
          position = channel.position as SoundPosition3d;
          await expectLater(
            Stream.fromIterable([position.x, position.y, position.z]),
            emitsInOrder(
              <double>[
                coordinates.x.toDouble(),
                coordinates.y.toDouble(),
                oldMove.z
              ],
            ),
          );
          final move = context.move;
          expect(move, zoneNpc.moves[1]);
          expect(context.moveIndex, 1);
          expect(
            context.timeUntilMove,
            inInclusiveRange(move.minMoveInterval, move.maxMoveInterval),
          );
          await level.tick(context.timeUntilMove);
          expect(
            context.coordinates,
            Point(
              coordinates.x + move.stepSize!,
              coordinates.y - move.stepSize!,
            ),
          );
        },
      );
      test(
        'Commands',
        () async {
          const moveCommandName = 'Move';
          const startPathCommandName = 'start';
          const endPathCommandName = 'stop';
          final results = <String>[];
          worldContext.customCommands[moveCommandName] =
              (final event) => results.add(moveCommandName);
          worldContext.customCommands[startPathCommandName] =
              (final event) => results.add(startPathCommandName);
          worldContext.customCommands[endPathCommandName] =
              (final event) => results.add(endPathCommandName);
          final moveCommand = WorldCommand(
            id: 'move',
            name: 'Move',
            customCommandName: moveCommandName,
          );
          final startPathCommand = WorldCommand(
            id: 'startPath',
            name: 'Start Path',
            customCommandName: startPathCommandName,
          );
          final endPathCommand = WorldCommand(
            id: 'endPath',
            name: endPathCommandName,
            customCommandName: endPathCommandName,
          );
          final category = CommandCategory(
            id: 'category',
            name: 'Movement Commands',
            commands: [moveCommand, startPathCommand, endPathCommand],
          );
          world.commandCategories.add(category);
          zoneNpc.moves.first
            ..startCommand = CallCommand(commandId: startPathCommand.id)
            ..moveCommand = CallCommand(commandId: moveCommand.id)
            ..endCommand = CallCommand(commandId: endPathCommand.id);
          context
            ..moveIndex = null
            ..timeUntilMove = 0;
          expect(() => context.move, throwsStateError);
          await level.tick(1);
          expect(context.move, zoneNpc.moves.first);
          expect(results.length, 1);
          expect(results.first, startPathCommandName);
          await level.tick(context.timeUntilMove);
          await expectLater(
            Stream.fromIterable(results),
            emitsInOrder(
              <String>[startPathCommandName, moveCommandName],
            ),
          );
          await level.tick(context.timeUntilMove);
          await expectLater(
            Stream.fromIterable(results),
            emitsInOrder(
              <String>[startPathCommandName, moveCommandName, moveCommandName],
            ),
          );
          final coordinates =
              zone.getAbsoluteCoordinates(middleMarker.coordinates);
          context.coordinates = Point(
            coordinates.x + 0.1,
            coordinates.y + 0.1,
          );
          expect(
            context.coordinates,
            Point(coordinates.x + 0.1, coordinates.y + 0.1),
          );
          await level.tick(context.timeUntilMove);
          expect(context.coordinates, coordinates);
          await expectLater(
            Stream.fromIterable(results),
            emitsInOrder(
              <String>[
                startPathCommandName,
                moveCommandName,
                moveCommandName,
                endPathCommandName
              ],
            ),
          );
        },
      );
    },
  );
}
