/// Provides the [getCreditsMenu] function.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../extensions.dart';
import '../json/world.dart';
import 'get_main_menu.dart';

/// Returns a menu that will show credits.
Menu getCreditsMenu({
  required Game game,
  required World world,
}) {
  final creditsMenuMusic = world.creditsMenuMusic;
  return Menu(
    game: game,
    title: Message(
      text: world.creditsMenuOptions.title,
    ),
    ambiances: [
      if (creditsMenuMusic != null) Ambiance(sound: creditsMenuMusic)
    ],
    items: [
      for (final credit in world.credits)
        MenuItem(
            Message(
              keepAlive: true,
              sound: credit.assetId == null
                  ? world.menuMoveSound
                  : world.creditsAssetStore.getAssetReferenceFromVariableName(
                      credit.assetId!,
                    ),
              text: credit.title,
            ),
            Button(
              () => credit.url == null ? null : game.outputText(credit.url!),
            ))
    ],
    onCancel: () => game.replaceLevel(
      getMainMenu(
        game: game,
        world: world,
      ),
      ambianceFadeTime: world.creditsMenuOptions.fadeTime,
    ),
  );
}
