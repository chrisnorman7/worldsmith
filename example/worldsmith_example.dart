import 'package:dart_sdl/dart_sdl.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/ziggurat.dart';

Future<void> main() {
  final sdl = Sdl();
  final world = World(
    title: 'Example World',
    credits: [
      WorldCredit(
        id: 'ziggurat',
        title: 'Chris Norman: Worldsmith',
        url: 'https://pub.dev/packages/worldsmith',
      )
    ],
    creditsMenuOptions: CreditsMenuOptions(fadeTime: 1.0),
    mainMenuOptions: MainMenuOptions(fadeTime: 1.0),
  );
  final game = Game(world.title, triggerMap: world.triggerMap);
  final worldContext = WorldContext(
    sdl: sdl,
    game: game,
    world: world,
  );
  return worldContext.run();
}
