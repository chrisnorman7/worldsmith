/// Provides the [PauseMenu] class.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../command_triggers.dart';
import '../../world_context.dart';
import '../json/zones/zone.dart';

/// The pause menu.
class PauseMenu extends Menu {
  /// Create an instance.
  PauseMenu(this.worldContext, this.zone)
      : super(
          game: worldContext.game,
          title: Message(text: worldContext.world.pauseMenuOptions.title),
          music: worldContext.world.pauseMenuMusic,
          items: [
            MenuItem(
              worldContext.getMenuItemMessage(text: zone.name),
              menuItemLabel,
            ),
            if (zone.topDownMap)
              MenuItem(
                worldContext.getCustomMessage(
                  worldContext.world.pauseMenuOptions.zoneOverviewMessage,
                  keepAlive: true,
                  nullSound: worldContext.world.menuMoveSound,
                ),
                worldContext.getButton(
                  () => worldContext.game.outputText('Not implemented.'),
                ),
              ),
            MenuItem(
              worldContext.getCustomMessage(
                worldContext.world.pauseMenuOptions.returnToGameMessage,
                keepAlive: true,
                nullSound: worldContext.world.menuMoveSound,
              ),
              worldContext.getButton(
                () => worldContext.game.popLevel(
                  ambianceFadeTime:
                      worldContext.world.pauseMenuOptions.fadeTime,
                ),
              ),
            ),
            MenuItem(
              worldContext.getCustomMessage(
                worldContext.world.pauseMenuOptions.returnToMainMenuMessage,
                keepAlive: true,
                nullSound: worldContext.world.menuMoveSound,
              ),
              worldContext.getButton(
                () {
                  worldContext.savePlayerPreferences();
                  final world = worldContext.world;
                  final options = world.pauseMenuOptions;
                  final fadeTime = options.returnToMainMenuFadeTime;
                  worldContext.game
                    ..popLevel()
                    ..replaceLevel(
                      worldContext.getMainMenu(),
                      ambianceFadeTime: fadeTime,
                    );
                },
              ),
            )
          ],
          onCancel: () {
            worldContext
              ..playMenuCancelSound()
              ..game.popLevel(
                ambianceFadeTime: worldContext.world.pauseMenuOptions.fadeTime,
              );
          },
        ) {
    registerCommand(
      switchMenuForwardCommandTrigger.name,
      Command(
        onStart: () {
          worldContext.playMenuSwitchSound();
          game.pushLevel(worldContext.getQuestMenu());
        },
      ),
    );
    registerCommand(
      switchMenuBackwardsCommandTrigger.name,
      Command(
        onStart: () {
          worldContext.playMenuSwitchSound();
          game.pushLevel(worldContext.getQuestMenu());
        },
      ),
    );
  }

  /// The world context to use.
  final WorldContext worldContext;

  /// The zone that has been paused.
  final Zone zone;
}
