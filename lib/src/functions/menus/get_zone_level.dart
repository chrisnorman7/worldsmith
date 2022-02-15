/// Provides the [getZoneLevel] function.
import '../../../world_context.dart';
import '../../json/zones/zone.dart';
import '../../level/zone_level.dart';

/// The default function for getting a zone level.
ZoneLevel getZoneLevel(WorldContext worldContext, Zone zone) =>
    ZoneLevel(worldContext: worldContext, zone: zone);
