import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../world_context.dart';

/// A menu for configuring sound options.
class SoundOptionsMenu extends ParameterMenu {
  /// Create an instance.
  SoundOptionsMenu(this.worldContext)
      : super(
          game: worldContext.game,
          title: Message(text: worldContext.world.soundMenuOptions.title),
          parameters: [
            worldContext.getGainParameter(
              title: worldContext
                  .world.soundMenuOptions.interfaceSoundsVolumeTitle,
              soundChannel: worldContext.game.interfaceSounds,
            ),
            worldContext.getGainParameter(
              title: worldContext.world.soundMenuOptions.musicVolumeTitle,
              soundChannel: worldContext.game.musicSounds,
            ),
            worldContext.getGainParameter(
              title:
                  worldContext.world.soundMenuOptions.ambianceSoundsVolumeTitle,
              soundChannel: worldContext.game.ambianceSounds,
            )
          ],
          music: worldContext.world.soundMenuMusic,
          onCancel: () => worldContext.game.replaceLevel(
            worldContext.getMainMenu(),
            ambianceFadeTime: worldContext.world.soundMenuOptions.fadeTime,
          ),
        ) {
    final options = worldContext.world.soundMenuOptions;
    menuItems.addAll(
      [
        MenuItem(
          worldContext.getMenuItemMessage(text: options.headphonesPresetTitle),
          worldContext.getButton(
            () {
              game.setDefaultPannerStrategy(DefaultPannerStrategy.hrtf);
            },
          ),
        ),
        MenuItem(
          worldContext.getMenuItemMessage(text: options.speakersPresetTitle),
          worldContext.getButton(
            () {
              game.setDefaultPannerStrategy(DefaultPannerStrategy.stereo);
            },
          ),
        )
      ],
    );
  }

  /// The world context to use.
  final WorldContext worldContext;
}
