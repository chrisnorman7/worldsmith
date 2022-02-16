/// Provides the [CreditsMenu] class.
import 'dart:io';

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
          ambiances: worldContext.creditsMenuAmbiances,
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
                          final String processName;
                          if (Platform.isWindows) {
                            processName = 'start';
                          } else {
                            processName = 'open';
                          }
                          Process.runSync(processName, url.split(' '));
                        },
                      ),
              )
          ],
          onCancel: () => worldContext.game.replaceLevel(
            worldContext.mainMenuBuilder(worldContext),
            ambianceFadeTime: worldContext.world.creditsMenuOptions.fadeTime,
          ),
        );
}
