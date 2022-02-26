import 'dart:math';

import 'package:test/test.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import '../../custom_game.dart';
import '../../pond_zone.dart';

void main() {
  group(
    'ZoneLevel class',
    () {
      final slowWalkReference = AssetReferenceReference(
        variableName: 'slow_walk',
        reference: AssetReference.file('slow_walk.mp3'),
      );
      final fastWalkReference = AssetReferenceReference(
        variableName: 'fast_walk',
        reference: AssetReference.file('fast_walk.mp3'),
      );
      final defaultTerrain = Terrain(
        id: 'terrain',
        name: 'Default Terrain',
        slowWalk: WalkingOptions(
          interval: 500,
          distance: 0.5,
          sound: Sound(id: slowWalkReference.variableName),
        ),
        fastWalk: WalkingOptions(
          interval: 400,
          distance: 0.5,
          sound: Sound(id: fastWalkReference.variableName),
        ),
      );
      final pondZone = PondZone.generate();
      final world = World(
        terrainAssets: [slowWalkReference, fastWalkReference],
        terrains: [defaultTerrain],
      );
      final game = CustomGame(world.title);
      final worldContext = WorldContext(game: game, world: world);
      pondZone.generateTerrains(world);
      final level = ZoneLevel(worldContext: worldContext, zone: pondZone.zone)
        ..onPush();
      test(
        'Initialisation',
        () {
          expect(level.coordinates, Point(0.0, 0.0));
          expect(level.coordinatesOffset, Point(2, 2));
          expect(level.heading, isZero);
          expect(level.tiles.length, level.size.x + 1);
          expect(level.tiles.first.length, level.size.y + 1);
        },
      );
      test(
        'getBox',
        () {
          expect(level.getBox(), pondZone.westBank);
          final point =
              pondZone.zone.getAbsoluteCoordinates(pondZone.pondBox.start);
          expect(
            level.getBox(
              Point(
                point.x + level.coordinatesOffset.x.toDouble(),
                point.y + level.coordinatesOffset.y.toDouble(),
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
          level.showCoordinates();
          expect(game.strings.length, 1);
          expect(game.strings.first, '0, 0');
          level
            ..coordinates = Point(pi, 15.54321)
            ..showCoordinates();
          expect(game.strings.length, 2);
          expect(game.strings.last, '3, 15');
        },
      );
      test(
        'showFacing',
        () {
          game.strings.clear();
          level.showFacing();
          expect(game.strings.length, 1);
          expect(game.strings.first, 'North (0 degrees)');
          level
            ..heading = 45
            ..showFacing();
          expect(game.strings.length, 2);
          expect(game.strings.last, 'Northeast (45 degrees)');
          level
            ..heading = 52
            ..showFacing();
          expect(game.strings.length, 3);
          expect(game.strings.last, 'Northeast (52 degrees)');
          level
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
            end.x + level.coordinatesOffset.x + 1,
            end.y + level.coordinatesOffset.y + 1,
          );
          expect(
            level.size,
            expected,
          );
          expect(
            () => level.getBox(
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
          final musicAsset = AssetReference.file('music.mp3');
          final musicReference = AssetReferenceReference(
            variableName: 'music',
            reference: musicAsset,
            comment: 'Level music',
          );
          world.musicAssets.add(musicReference);
          final music = Sound(id: musicReference.variableName, gain: 2.0);
          final zone = Zone(
            id: 'zone',
            name: 'Test Zone',
            boxes: [],
            music: music,
            defaultTerrainId: defaultTerrain.id,
          );
          world.zones.add(zone);
          final zoneLevel = ZoneLevel(worldContext: worldContext, zone: zone);
          expect(zoneLevel.ambiances.length, 1);
          final levelMusic = zoneLevel.ambiances.first;
          expect(levelMusic.gain, music.gain);
          expect(levelMusic.position, isNull);
          expect(levelMusic.sound, musicAsset);
        },
      );
    },
  );
}
