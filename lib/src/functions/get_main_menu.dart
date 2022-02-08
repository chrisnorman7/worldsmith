/// Provides the [getMainMenu] function.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../json/world.dart';
import 'get_credits_menu.dart';

/// Get the main menu for the given [world].
Menu getMainMenu({
  required Game game,
  required World world,
}) {
  void unimplemented() => game.outputText('Unimplemented.');
  final mainMenuMusic = world.mainMenuMusic;
  final moveSound = world.menuMoveSound;
  final activateSound = world.menuActivateSound;
  return Menu(
    game: game,
    title: Message(text: world.mainMenuOptions.options.title),
    ambiances: [if (mainMenuMusic != null) Ambiance(sound: mainMenuMusic)],
    items: [
      MenuItem(
        Message(
          keepAlive: true,
          sound: moveSound,
          text: world.mainMenuOptions.newGameTitle,
        ),
        Button(
          unimplemented,
          activateSound: activateSound,
        ),
      ),
      MenuItem(
        Message(
          keepAlive: true,
          sound: moveSound,
          text: world.mainMenuOptions.savedGameTitle,
        ),
        Button(
          unimplemented,
          activateSound: activateSound,
        ),
      ),
      if (world.credits.isNotEmpty)
        MenuItem(
          Message(
            keepAlive: true,
            sound: moveSound,
            text: world.mainMenuOptions.creditsTitle,
          ),
          Button(
            () => game.pushLevel(
              getCreditsMenu(
                game: game,
                world: world,
              ),
            ),
            activateSound: activateSound,
          ),
        ),
      MenuItem(
        Message(
          keepAlive: true,
          sound: moveSound,
          text: world.mainMenuOptions.exitTitle,
        ),
        Button(game.stop, activateSound: activateSound),
      )
    ],
  );
}
