import 'dart:math';

import 'package:test/test.dart';

import '../../../pond_zone.dart';

void main() {
  group(
    'Zone class',
    () {
      final pondZone = PondZone.generate();
      final pond = pondZone.pondBox;
      final northBank = pondZone.northBank;
      final southBank = pondZone.southBank;
      final eastBank = pondZone.eastBank;
      final westBank = pondZone.westBank;
      final z = pondZone.zone;
      test(
        'Initialisation',
        () {
          expect(z.boxes, contains(pond));
          expect(z.boxes, contains(northBank));
          expect(z.boxes, contains(southBank));
          expect(z.boxes, contains(eastBank));
          expect(z.boxes, contains(westBank));
          expect(z.music, isNull);
          expect(z.topDownMap, isTrue);
          expect(z.ambiances, isEmpty);
        },
      );
      test(
        'getAbsoluteCoordinates',
        () {
          expect(z.getAbsoluteCoordinates(pond.start), const Point(0, 0));
          expect(z.getAbsoluteCoordinates(pond.end), const Point(5, 5));
          expect(z.getBoxSoutheastCorner(pond), const Point(5, 0));
          expect(z.getBoxNorthwestCorner(pond), const Point(0, 5));
          expect(z.getAbsoluteCoordinates(northBank.start), const Point(0, 6));
          expect(z.getAbsoluteCoordinates(northBank.end), const Point(5, 7));
          expect(
            z.getBoxNorthwestCorner(northBank),
            const Point(0, 7),
          );
          expect(z.getBoxSoutheastCorner(northBank), const Point(5, 6));
          expect(z.getAbsoluteCoordinates(westBank.start), const Point(-2, -2));
          expect(z.getAbsoluteCoordinates(westBank.end), const Point(-1, 7));
          expect(
            z.getBoxNorthwestCorner(westBank),
            const Point(-2, 7),
          );
          expect(z.getAbsoluteCoordinates(eastBank.end), const Point(7, 7));
        },
      );
    },
  );
}
