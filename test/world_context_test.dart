import 'package:test/test.dart';
import 'package:worldsmith/functions.dart';
import 'package:worldsmith/src/json/world.dart';
import 'package:worldsmith/world_context.dart';
import 'package:ziggurat/ziggurat.dart';

void main() {
  group(
    'WorldContext class',
    () {
      final world = World(title: 'Test WorldContext Class');
      final game = Game(world.title);
      final worldContext = WorldContext(game: game, world: world);
      test(
        'Initialisation',
        () {
          expect(worldContext.game, game);
          expect(worldContext.world, world);
          expect(worldContext.creditsMenuAmbiances, isEmpty);
          expect(worldContext.creditsMenuBuilder, getCreditsMenu);
          expect(worldContext.mainMenuAmbiances, isEmpty);
          expect(worldContext.mainMenuBuilder, getMainMenu);
          expect(worldContext.pauseMenuAmbiances, isEmpty);
          expect(worldContext.pauseMenuBuilder, getPauseMenu);
          expect(worldContext.zoneMenuBuilder, getZoneLevel);
        },
      );
    },
  );
}
