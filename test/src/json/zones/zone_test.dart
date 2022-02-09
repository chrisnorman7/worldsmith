import 'dart:math';

import 'package:test/test.dart';
import 'package:worldsmith/worldsmith.dart';

void main() {
  group(
    'Zone class',
    () {
      final pond = Box(
        id: 'pond',
        name: 'Pond',
        start: Coordinates(0, 0),
        end: Coordinates(5, 5),
        terrainId: 'water',
      );
      final northBank = Box(
        id: 'north_bank',
        name: 'North Bank',
        start: Coordinates(
          0,
          1,
          clamp: CoordinateClamp(boxId: pond.id, corner: BoxCorner.northwest),
        ),
        end: Coordinates(
          0,
          2,
          clamp: CoordinateClamp(boxId: pond.id, corner: BoxCorner.northeast),
        ),
        terrainId: 'grass',
      );
      final southBank = Box(
          id: 'southBank',
          name: 'South Bank',
          start: Coordinates(
            0,
            -2,
            clamp: CoordinateClamp(boxId: pond.id, corner: BoxCorner.southwest),
          ),
          end: Coordinates(
            0,
            -1,
            clamp: CoordinateClamp(boxId: pond.id, corner: BoxCorner.southeast),
          ),
          terrainId: 'grass');
      final eastBank = Box(
        id: 'eastBank',
        name: 'East Bank',
        start: Coordinates(
          1,
          0,
          clamp: CoordinateClamp(
            boxId: southBank.id,
            corner: BoxCorner.southeast,
          ),
        ),
        end: Coordinates(
          1,
          2,
          clamp: CoordinateClamp(
            boxId: northBank.id,
            corner: BoxCorner.northeast,
          ),
        ),
        terrainId: 'grass',
      );
      final westBank = Box(
        id: 'westBank',
        name: 'West Bank',
        start: Coordinates(
          -2,
          0,
          clamp: CoordinateClamp(
            boxId: southBank.id,
            corner: BoxCorner.southwest,
          ),
        ),
        end: Coordinates(
          -1,
          0,
          clamp:
              CoordinateClamp(boxId: northBank.id, corner: BoxCorner.northwest),
        ),
        terrainId: 'grass',
      );
      final z = Zone(
        id: 'testZone',
        name: 'Test Zone',
        boxes: [
          pond,
          northBank,
          southBank,
          eastBank,
          westBank,
        ],
        defaultTerrainId: 'terrain',
      );
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
        },
      );
    },
  );
}
