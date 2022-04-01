import 'package:worldsmith/worldsmith.dart';

class PondZone {
  /// Create an instance.
  const PondZone({
    required this.pondBox,
    required this.northBank,
    required this.southBank,
    required this.eastBank,
    required this.westBank,
    required this.zone,
  });

  /// Generate an instance.
  factory PondZone.generate() {
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
      id: 'south_bank',
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
      terrainId: 'grass',
    );
    final eastBank = Box(
      id: 'east_bank',
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
        2,
        0,
        clamp: CoordinateClamp(
          boxId: northBank.id,
          corner: BoxCorner.northeast,
        ),
      ),
      terrainId: 'grass',
    );
    final westBank = Box(
      id: 'west_bank',
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
        clamp: CoordinateClamp(
          boxId: northBank.id,
          corner: BoxCorner.northwest,
        ),
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
    return PondZone(
      pondBox: pond,
      northBank: northBank,
      southBank: southBank,
      eastBank: eastBank,
      westBank: westBank,
      zone: z,
    );
  }

  /// Pond box.
  final Box pondBox;

  /// North bank.
  final Box northBank;

  /// South field.
  final Box southBank;

  /// East field.
  final Box eastBank;

  /// West field.
  final Box westBank;

  /// The created zone.
  final Zone zone;

  /// Generate the needed terrains.
  void generateTerrains(final World world) {
    for (final box in [northBank, eastBank, southBank, westBank, pondBox]) {
      final terrainId = box.terrainId;
      world.terrains.add(
        Terrain(
          id: terrainId,
          name: terrainId,
          slowWalk: WalkingOptions(
            interval: 500,
            sound: Sound(id: '${terrainId}_slow.mp3'),
          ),
          fastWalk: WalkingOptions(
            interval: 250,
            distance: 0.4,
            sound: Sound(id: '${terrainId}_fast.mp3'),
          ),
        ),
      );
    }
    world.terrains.add(
      Terrain(
        id: zone.defaultTerrainId,
        name: 'Zone Terrain',
        slowWalk: WalkingOptions(
          interval: 500,
          sound: Sound(id: 'zone_terrain.mp3'),
        ),
        fastWalk: WalkingOptions(
          interval: 400,
          distance: 0.4,
          sound: Sound(id: 'slow_walk.mp3'),
        ),
      ),
    );
  }
}
