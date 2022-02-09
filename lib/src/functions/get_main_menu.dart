/// Provides the [getMainMenu] function.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

import '../json/world.dart';
import 'get_credits_menu.dart';
import 'menus.dart';

/// Get the main menu for the given [world].
Menu getMainMenu({
  required Game game,
  required World world,
}) {
  void unimplemented() => game.outputText('Unimplemented.');
  final mainMenuMusic = world.mainMenuMusic;
  final options = world.mainMenuOptions;
  return Menu(
    game: game,
    title: Message(text: options.title),
    ambiances: [
      if (mainMenuMusic != null) mainMenuMusic,
    ],
    items: [
      MenuItem(
        makeMenuItemMessage(world, text: options.newGameTitle),
        makeButton(world, unimplemented),
      ),
      MenuItem(
        makeMenuItemMessage(world, text: options.savedGameTitle),
        makeButton(world, unimplemented),
      ),
      if (world.credits.isNotEmpty)
        MenuItem(
          makeMenuItemMessage(world, text: options.creditsTitle),
          makeButton(
            world,
            () => game.replaceLevel(
              getCreditsMenu(
                game: game,
                world: world,
              ),
              ambianceFadeTime: options.fadeTime,
            ),
          ),
        ),
      MenuItem(
        makeMenuItemMessage(
          world,
          text: options.exitTitle,
        ),
        makeButton(
          world,
          () {
            final fadeTime = options.fadeTime;
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
}
