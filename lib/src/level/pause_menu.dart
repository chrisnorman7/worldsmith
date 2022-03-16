/// Provides the [PauseMenu] class.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../command_triggers.dart';
import '../../util.dart';
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
          ],
          onCancel: () {
            final sound = worldContext.world.soundOptions.menuCancelSound;
            if (sound != null) {
              playSound(
                channel: worldContext.game.interfaceSounds,
                sound: sound,
                assets: worldContext.world.interfaceSoundsAssets,
              );
            }
            worldContext.game.popLevel(
              ambianceFadeTime: worldContext.world.pauseMenuOptions.fadeTime,
            );
          },
        ) {
    registerCommand(
      switchMenuForwardCommandTrigger.name,
      Command(
        onStart: () => game.pushLevel(
          worldContext.getQuestMenu(),
        ),
      ),
    );
    registerCommand(
      switchMenuBackwardsCommandTrigger.name,
      Command(
        onStart: () => game.pushLevel(worldContext.getQuestMenu()),
      ),
    );
  }

  /// The world context to use.
  final WorldContext worldContext;

  /// The zone that has been paused.
  final Zone zone;
}
