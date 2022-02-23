import 'dart:math';

import 'package:test/test.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';

import '../../custom_game.dart';
import '../../pond_zone.dart';

void main() {
  group(
    'ZoneLevel class',
    () {
      final pondZone = PondZone.generate();
      final world = World(zones: [pondZone.zone]);
      pondZone.generateTerrains(world);
      final game = CustomGame(world.title);
      final worldContext = WorldContext(game: game, world: world);
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
    },
  );
}
