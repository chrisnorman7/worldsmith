/// Provides the [getPauseMenu] class.
import '../../../world_context.dart';
import '../../json/zones/zone.dart';
import '../../level/pause_menu.dart';

/// The default function for getting a pause menu.
PauseMenu getPauseMenu(WorldContext worldContext, Zone zone) =>
    PauseMenu(worldContext, zone);
