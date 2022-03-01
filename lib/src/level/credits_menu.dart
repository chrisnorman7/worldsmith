import 'package:open_url/open_url.dart';
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../util.dart';
import '../../world_context.dart';

/// The credits menu.
class CreditsMenu extends Menu {
  /// Create an instance.
  CreditsMenu(WorldContext worldContext)
      : super(
          game: worldContext.game,
          title: Message(text: worldContext.world.creditsMenuOptions.title),
          music: worldContext.world.creditsMenuMusic,
          items: [
            for (final credit in worldContext.world.credits)
              MenuItem(
                Message(
                  gain: credit.sound?.gain ??
                      worldContext.world.soundOptions.menuMoveSound?.gain ??
                      worldContext.world.soundOptions.defaultGain,
                  keepAlive: true,
                  sound: getAssetReferenceReference(
                              assets: worldContext.world.creditsAssets,
                              id: credit.sound?.id)
                          ?.reference ??
                      worldContext.world.menuMoveSound,
                  text: credit.title,
                ),
                credit.url == null
                    ? menuItemLabel
                    : worldContext.getButton(
                        () {
                          final url = credit.url!;
                          worldContext.game.outputText('Opening $url.');
                          openUrl(url);
                        },
                      ),
              )
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
            worldContext.game.replaceLevel(
              worldContext.getMainMenu(),
              ambianceFadeTime: worldContext.world.creditsMenuOptions.fadeTime,
            );
          },
        );
}
