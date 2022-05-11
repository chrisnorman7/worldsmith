/// Provides the [MainMenu] class.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../util.dart';
import '../../world_context.dart';
import '../json/commands/world_command.dart';

void _unimplemented(final Game game) => game.outputText('Unimplemented.');

/// The main menu for the given [worldContext].
class MainMenu extends Menu {
  /// Create an instance.
  MainMenu(this.worldContext)
      : super(
          game: worldContext.game,
          title: Message(text: worldContext.world.mainMenuOptions.title),
          music: worldContext.world.mainMenuMusic,
          items: [],
        ) {
    final world = worldContext.world;
    final options = world.mainMenuOptions;
    final fadeTime = options.fadeTime;
    final startGameCommandId = world.mainMenuOptions.startGameCommandId;
    final WorldCommand command;
    if (startGameCommandId == null) {
      command = WorldCommand(
        id: '',
        name: 'Faked Start Game Command',
        text: 'The start game command has not been set.',
      );
    } else {
      command = world.getCommand(startGameCommandId);
    }
    menuItems.addAll(
      [
        MenuItem(
          worldContext.getMenuItemMessage(
            text: options.newGameString,
            sound: options.newGameSound,
          ),
          worldContext.getButton(
            () {
              worldContext.playerPreferences.questStages.clear();
              worldContext.runCommand(command: command);
            },
          ),
        ),
        MenuItem(
          worldContext.getMenuItemMessage(
            text: options.savedGameString,
            sound: options.savedGameSound,
          ),
          worldContext.getButton(() => _unimplemented(worldContext.game)),
        ),
        if (world.credits.isNotEmpty)
          MenuItem(
            worldContext.getMenuItemMessage(
              text: options.creditsString,
              sound: options.creditsSound,
            ),
            worldContext.getButton(
              () => worldContext.game.replaceLevel(
                worldContext.getCreditsMenu(),
                ambianceFadeTime: fadeTime,
              ),
            ),
          ),
        MenuItem(
          worldContext.getMenuItemMessage(
            sound: options.controlsMenuSound,
            text: options.controlsMenuString,
          ),
          worldContext.getButton(
            () => game.replaceLevel(
              worldContext.getControlsMenu(),
              ambianceFadeTime: fadeTime,
            ),
          ),
        ),
        MenuItem(
          worldContext.getMenuItemMessage(
            text: options.soundOptionsString,
            sound: options.soundOptionsSound,
          ),
          worldContext.getButton(
            () => game.replaceLevel(
              worldContext.getSoundOptionsMenu(),
              ambianceFadeTime: fadeTime,
            ),
          ),
        ),
        MenuItem(
          worldContext.getMenuItemMessage(
            text: options.exitString,
            sound: options.exitSound,
          ),
          worldContext.getButton(
            () {
              final sound = options.onExitSound;
              final game = worldContext.game
                ..outputMessage(
                  worldContext.getCustomMessage(
                    message: options.onExitString,
                    gain: sound?.gain,
                    sound: sound == null
                        ? null
                        : getAssetReferenceReference(
                            assets: world.interfaceSoundsAssets,
                            id: sound.id,
                          ).reference,
                  ),
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
    for (final commandTrigger in world.customCommandTriggers.where(
      (final element) => element.mainMenu == true,
    )) {
      registerCommand(
        commandTrigger.commandTrigger.name,
        commandTrigger.getCommand(worldContext),
      );
    }
  }

  /// The world context to work with.
  final WorldContext worldContext;
}
