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
      final game = CustomGame(world.title);
      final worldContext = WorldContext(game: game, world: world);
      final level = ZoneLevel(worldContext: worldContext, zone: pondZone.zone);
      test(
        'Initialisation',
        () {
          expect(level.coordinates, Point(0.0, 0.0));
          expect(level.coordinatesOffset, Point(2, 2));
          expect(level.heading, isZero);
          expect(level.tiles.length, 9);
          expect(level.tiles.first.length, 9);
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
          expect(game.strings.first, 'North');
          level
            ..heading = 45
            ..showFacing();
          expect(game.strings.length, 2);
          expect(game.strings.last, 'Northeast');
          level
            ..heading = 52
            ..showFacing();
          expect(game.strings.length, 3);
          expect(game.strings.last, 'Northeast');
          level
            ..heading = 359
            ..showFacing();
          expect(game.strings.last, 'Northwest');
        },
      );
    },
  );
}
