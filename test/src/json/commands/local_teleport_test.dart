import 'dart:math';

import 'package:test/test.dart';
import 'package:worldsmith/worldsmith.dart';

import '../../../pond_zone.dart';

void main() {
  final random = Random();
  final pondZone = PondZone.generate();
  final zone = pondZone.zone;
  group(
    'LocalTeleport',
    () {
      test(
        'No random without clamp',
        () {
          final teleport = LocalTeleport(minCoordinates: Coordinates(1, 2));
          expect(
            teleport.getCoordinates(zone: zone, random: random),
            Point(teleport.minCoordinates.x, teleport.minCoordinates.y),
          );
        },
      );
      test(
        'No random with clamp',
        () {
          final teleport = LocalTeleport(
            minCoordinates: Coordinates(
              0,
              0,
              clamp: CoordinateClamp(
                boxId: pondZone.pondBox.id,
                corner: BoxCorner.southwest,
              ),
            ),
          );
          expect(
            teleport.getCoordinates(zone: zone, random: random),
            zone.getAbsoluteCoordinates(pondZone.pondBox.start),
          );
        },
      );
      test(
        'Random without clamp',
        () {
          final teleport = LocalTeleport(
            minCoordinates: Coordinates(0, 0),
            maxCoordinates: Coordinates(10, 10),
          );
          for (var i = 0; i < 100; i++) {
            final coordinates = teleport.getCoordinates(
              zone: zone,
              random: random,
            );
            expect(coordinates.x, inClosedOpenRange(0, 10));
            expect(coordinates.y, inClosedOpenRange(0, 10));
          }
        },
      );
      test(
        'Random with clamp',
        () {
          final teleport = LocalTeleport(
            minCoordinates: Coordinates(
              0,
              0,
              clamp: CoordinateClamp(
                boxId: pondZone.westBank.id,
                corner: BoxCorner.southwest,
              ),
            ),
            maxCoordinates: Coordinates(
              0,
              0,
              clamp: CoordinateClamp(
                boxId: pondZone.eastBank.id,
                corner: BoxCorner.northeast,
              ),
            ),
          );
          final startCoordinates = zone.getAbsoluteCoordinates(
            pondZone.westBank.start,
          );
          final endCoordinates = zone.getAbsoluteCoordinates(
            pondZone.eastBank.end,
          );
          for (var i = 0; i < 100; i++) {
            final coordinates = teleport.getCoordinates(
              zone: zone,
              random: random,
            );
            expect(
              coordinates.x,
              inClosedOpenRange(startCoordinates.x, endCoordinates.x),
            );
            expect(
              coordinates.y,
              inClosedOpenRange(startCoordinates.y, endCoordinates.y),
            );
          }
        },
      );
    },
  );
}
