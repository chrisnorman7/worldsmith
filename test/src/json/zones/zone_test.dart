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
          expect(z.getAbsoluteCoordinates(pond.start), Point(0, 0));
          expect(z.getAbsoluteCoordinates(pond.end), Point(5, 5));
          expect(z.getBoxSoutheastCorner(pond), Point(5, 0));
          expect(z.getBoxNorthwestCorner(pond), Point(0, 5));
          expect(z.getAbsoluteCoordinates(northBank.start), Point(0, 6));
          expect(z.getAbsoluteCoordinates(northBank.end), Point(5, 7));
          expect(
            z.getBoxNorthwestCorner(northBank),
            Point(0, 7),
          );
          expect(z.getBoxSoutheastCorner(northBank), Point(5, 6));
          expect(z.getAbsoluteCoordinates(westBank.start), Point(-2, -2));
          expect(z.getAbsoluteCoordinates(westBank.end), Point(-1, 7));
          expect(
            z.getBoxNorthwestCorner(westBank),
            Point(-2, 7),
          );
          expect(z.getAbsoluteCoordinates(eastBank.end), Point(7, 7));
        },
      );
    },
  );
}
