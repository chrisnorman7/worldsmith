import 'package:test/test.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

void main() {
  group(
    'PauseMenu class',
    () {
      final zone = Zone(
        id: 'zone',
        name: 'Test Zone',
        boxes: [],
        defaultTerrainId: 'terrain',
      );
      final world = World(zones: [zone], pauseMenuOptions: PauseMenuOptions());
      final game = Game(world.title);
      final worldContext = WorldContext(game: game, world: world);
      test(
        'Initialisation',
        () {
          final menu = PauseMenu(worldContext, zone);
          expect(menu.menuItems.length, 3);
          final zoneNameMenuItem = menu.menuItems.first;
          expect(zoneNameMenuItem.label.gain, world.soundOptions.defaultGain);
          expect(zoneNameMenuItem.label.keepAlive, isTrue);
          expect(zoneNameMenuItem.label.sound, isNull);
          expect(zoneNameMenuItem.label.text, zone.name);
          expect(zoneNameMenuItem.widget, menuItemLabel);
          final overviewMenuItem = menu.menuItems[1];
          expect(overviewMenuItem.label.gain, world.soundOptions.defaultGain);
          expect(overviewMenuItem.label.sound, isNull);
          expect(
            overviewMenuItem.label.text,
            world.pauseMenuOptions.zoneOverviewLabel,
          );
          expect(overviewMenuItem.widget, isA<Button>());
          final returnToGameMenuItem = menu.menuItems.last;
          expect(
            returnToGameMenuItem.label.gain,
            world.soundOptions.defaultGain,
          );
          expect(returnToGameMenuItem.label.keepAlive, isTrue);
          expect(returnToGameMenuItem.label.sound, isNull);
          expect(
            returnToGameMenuItem.label.text,
            world.pauseMenuOptions.returnToGameTitle,
          );
          expect(returnToGameMenuItem.widget, isA<Button>());
        },
      );
    },
  );
}
