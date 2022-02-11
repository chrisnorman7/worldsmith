/// Provides the [getCreditsMenu] function.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../util.dart';
import '../json/world.dart';
import 'get_main_menu.dart';
import 'menus.dart';

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
            gain: credit.sound?.gain ??
                world.soundOptions.menuMoveSound?.gain ??
                world.soundOptions.defaultGain,
            keepAlive: true,
            sound: getAssetReferenceReference(
                  assets: world.creditsAssets,
                  id: credit.sound?.id,
                )?.reference ??
                world.menuMoveSound,
            text: credit.title,
          ),
          makeButton(
            world,
            () => credit.url == null ? null : game.outputText(credit.url!),
          ),
        )
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
