/// Provides the [PauseMenu] class.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../functions/menus.dart';
import '../json/world.dart';
import '../json/zones/zone.dart';

/// The pause menu.
class PauseMenu extends Menu {
  /// Create an instance.
  PauseMenu({
    required Game game,
    required this.world,
    required this.zone,
  }) : super(
          game: game,
          title: Message(text: world.pauseMenuOptions.title),
          ambiances: [
            if (world.pauseMenuOptions.music != null)
              Ambiance(
                sound: world.creditsMenuMusic!,
                gain: world.creditsMenuOptions.music!.gain,
              ),
          ],
          items: [
            MenuItem(
                makeMenuItemMessage(world, text: zone.name), menuItemLabel),
            MenuItem(
              makeMenuItemMessage(world,
                  text: world.pauseMenuOptions.returnToGameTitle),
              makeButton(
                world,
                () => game.popLevel(
                  ambianceFadeTime: world.pauseMenuOptions.fadeTime,
                ),
              ),
            )
          ],
          onCancel: () => game.popLevel(
            ambianceFadeTime: world.pauseMenuOptions.fadeTime,
          ),
        );

  /// The world to use.
  final World world;

  /// The zone that has been paused.
  final Zone zone;
}
