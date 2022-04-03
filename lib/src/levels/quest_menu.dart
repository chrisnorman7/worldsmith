/// Provides the [QuestMenu] class.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../command_triggers.dart';
import '../../util.dart';
import '../../world_context.dart';

/// A menu for showing which quests have been completed so far.
class QuestMenu extends Menu {
  /// Create an instance.
  QuestMenu({required this.worldContext})
      : super(
          game: worldContext.game,
          title: Message(text: worldContext.world.questMenuOptions.title),
          items: [
            if (worldContext.playerPreferences.questStages.isEmpty)
              MenuItem(
                worldContext.getMenuItemMessage(
                  text: worldContext.world.questMenuOptions.noQuestsMessage,
                ),
                menuItemLabel,
              ),
            ...worldContext.playerPreferences.questStages.entries.map<MenuItem>(
              (final e) {
                final world = worldContext.world;
                final quest = world.getQuest(e.key);
                final stage = quest.getStage(e.value);
                final sound = stage.sound;
                final assetReference = sound == null
                    ? null
                    : getAssetReferenceReference(
                        assets: world.questAssets,
                        id: sound.id,
                      ).reference;
                return MenuItem(
                  Message(
                    gain: sound?.gain ?? world.soundOptions.defaultGain,
                    keepAlive: true,
                    sound: assetReference,
                    text: stage.description,
                  ),
                  menuItemLabel,
                );
              },
            ).toList()
          ],
          onCancel: () {
            worldContext.playMenuCancelSound();
            worldContext.game.popLevel();
          },
        ) {
    registerCommand(
      switchMenuBackwardsCommandTrigger.name,
      Command(
        onStart: () {
          worldContext.playMenuSwitchSound();
          game.popLevel();
        },
      ),
    );
    registerCommand(
      switchMenuForwardCommandTrigger.name,
      Command(
        onStart: () {
          worldContext.playMenuSwitchSound();
          game.popLevel();
        },
      ),
    );
  }

  /// The world context to use.
  final WorldContext worldContext;
}
