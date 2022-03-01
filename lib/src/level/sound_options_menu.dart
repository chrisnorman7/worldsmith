import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../util.dart';
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
              ambianceFadeTime: worldContext.world.soundMenuOptions.fadeTime,
            );
          },
        ) {
    menuItems.add(
      ParameterMenuParameter(
        getLabel: () {
          final world = worldContext.world;
          final options = world.soundMenuOptions;
          final title = options.outputTypeTitle;
          final String value;
          switch (worldContext.playerPreferences.pannerStrategy) {
            case DefaultPannerStrategy.stereo:
              value = options.speakersPresetTitle;
              break;
            case DefaultPannerStrategy.hrtf:
              value = options.headphonesPresetTitle;
              break;
          }
          return Message(
            gain: world.soundOptions.defaultGain,
            keepAlive: true,
            sound: world.menuMoveSound,
            text: '$title $value',
          );
        },
        increaseValue: () => changePannerStrategy(1),
        decreaseValue: () => changePannerStrategy(-1),
      ),
    );
  }

  /// The world context to use.
  final WorldContext worldContext;

  /// Change the panning strategy.
  void changePannerStrategy(int direction) {
    final world = worldContext.world;
    var index = worldContext.playerPreferences.pannerStrategy.index + direction;
    if (index >= DefaultPannerStrategy.values.length) {
      index = 0;
    } else if (index < 0) {
      index = DefaultPannerStrategy.values.length - 1;
    }
    worldContext.playerPreferences.pannerStrategy =
        DefaultPannerStrategy.values[index];
    worldContext.savePlayerPreferences();
    final options = world.soundMenuOptions;
    final String name;
    switch (worldContext.playerPreferences.pannerStrategy) {
      case DefaultPannerStrategy.stereo:
        name = options.speakersPresetTitle;
        break;
      case DefaultPannerStrategy.hrtf:
        name = options.headphonesPresetTitle;
        break;
    }
    game.outputMessage(
      Message(
        gain: world.soundOptions.defaultGain,
        sound: world.menuActivateSound,
        text: name,
      ),
    );
  }
}
