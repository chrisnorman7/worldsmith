import 'dart:math';

import 'package:test/test.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../pond_zone.dart';

void main() {
  group(
    'ZoneLevel class',
    () {
      final pondZone = PondZone.generate();
      final world = World(zones: [pondZone.zone]);
      final game = Game('Test Game');
      final level = ZoneLevel(game: game, world: world, zone: pondZone.zone);
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
    },
  );
}
