/// Provides the [MainMenu] class.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../world_context.dart';
import '../json/commands/world_command.dart';
import '../json/messages/custom_message.dart';

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
          items: [],
        ) {
    final world = worldContext.world;
    final options = world.mainMenuOptions;
    final fadeTime = options.fadeTime;
    final menuMoveAsset = world.menuMoveSound;
    final startGameCommandId = world.mainMenuOptions.startGameCommandId;
    final WorldCommand command;
    if (startGameCommandId == null) {
      command = WorldCommand(
        id: '',
        name: 'Faked Start Game Command',
        message: CustomMessage(
          text: 'The start game command has not been set.',
        ),
      );
    } else {
      command = world.getCommand(startGameCommandId);
    }
    menuItems.addAll(
      [
        MenuItem(
          worldContext.getCustomMessage(
            options.newGameMessage,
            keepAlive: true,
            nullSound: menuMoveAsset,
          ),
          worldContext.getWorldCommandButton(command),
        ),
        MenuItem(
          worldContext.getCustomMessage(
            options.savedGameMessage,
            keepAlive: true,
            nullSound: menuMoveAsset,
          ),
          worldContext.getButton(() => _unimplemented(worldContext.game)),
        ),
        if (world.credits.isNotEmpty)
          MenuItem(
            worldContext.getCustomMessage(
              options.creditsMessage,
              keepAlive: true,
              nullSound: menuMoveAsset,
            ),
            worldContext.getButton(
              () => worldContext.game.replaceLevel(
                worldContext.getCreditsMenu(),
                ambianceFadeTime: fadeTime,
              ),
            ),
          ),
        MenuItem(
          worldContext.getCustomMessage(
            options.exitMessage,
            keepAlive: true,
            nullSound: menuMoveAsset,
          ),
          worldContext.getButton(
            () {
              final game = worldContext.game
                ..outputMessage(
                  worldContext.getCustomMessage(options.onExitMessage),
                );
              if (fadeTime != null) {
                game
                  ..popLevel(ambianceFadeTime: fadeTime)
                  ..callAfter(
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

  /// The world context to work with.
  final WorldContext worldContext;
}
