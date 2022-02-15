/// Provides the [MainMenu] class.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../world_context.dart';

void _unimplemented(Game game) => game.outputText('Unimplemented.');

/// The main menu for the given [worldContext].
class MainMenu extends Menu {
  /// Create an instance.
  MainMenu(this.worldContext)
      : super(
          game: worldContext.game,
          title: Message(text: worldContext.world.mainMenuOptions.title),
          ambiances: [
            if (worldContext.world.mainMenuMusic != null)
              worldContext.world.mainMenuMusic!,
          ],
          items: [
            MenuItem(
              worldContext.getMenuItemMessage(
                text: worldContext.world.mainMenuOptions.newGameTitle,
              ),
              worldContext.getButton(() => _unimplemented(worldContext.game)),
            ),
            MenuItem(
              worldContext.getMenuItemMessage(
                text: worldContext.world.mainMenuOptions.savedGameTitle,
              ),
              worldContext.getButton(() => _unimplemented(worldContext.game)),
            ),
            if (worldContext.world.credits.isNotEmpty)
              MenuItem(
                worldContext.getMenuItemMessage(
                  text: worldContext.world.mainMenuOptions.creditsTitle,
                ),
                worldContext.getButton(
                  () => worldContext.game.replaceLevel(
                    worldContext.creditsMenuBuilder(worldContext),
                    ambianceFadeTime:
                        worldContext.world.mainMenuOptions.fadeTime,
                  ),
                ),
              ),
            MenuItem(
              worldContext.getMenuItemMessage(
                text: worldContext.world.mainMenuOptions.exitTitle,
              ),
              worldContext.getButton(
                () {
                  final game = worldContext.game;
                  final world = worldContext.world;
                  game.outputText(world.mainMenuOptions.exitMessage);
                  final fadeTime = world.mainMenuOptions.fadeTime;
                  if (fadeTime != null) {
                    game
                      ..popLevel(ambianceFadeTime: fadeTime)
                      ..registerTask(
                        runAfter: (fadeTime * 1000).floor(),
                        func: game.stop,
                      );
                  } else {
                    game.stop();
                  }
                },
              ),
            )
          ],
        );

  /// The world context to work with.
  final WorldContext worldContext;
}
