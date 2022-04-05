import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
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
      final game = CustomGame(world.title);
      final worldContext = WorldContext(sdl: sdl, game: game, world: world);
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
}
