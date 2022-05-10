/// Provides the [CustomMenuLevel] class.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../util.dart';
import '../../world_context.dart';
import '../json/menus/custom_menu.dart';

/// A level to render a [CustomMenu] instance.
class CustomMenuLevel extends Menu {
  /// Create an instance.
  CustomMenuLevel({
    required final WorldContext worldContext,
    required final CustomMenu customMenu,
  }) : super(
          game: worldContext.game,
          title: Message(text: customMenu.title),
          ambiances: [
            if (customMenu.music != null)
              Ambiance(
                sound: getAssetReferenceReference(
                  assets: worldContext.world.musicAssets,
                  id: customMenu.music!.id,
                ).reference,
                gain: customMenu.music!.gain,
              )
          ],
          items: customMenu.items.map<MenuItem>(
            (final e) {
              final sound = e.sound;
              final activateCommand = e.activateCommand;
              final world = worldContext.world;
              return MenuItem(
                Message(
                  gain: sound?.gain ?? world.soundOptions.defaultGain,
                  keepAlive: true,
                  sound: sound == null
                      ? null
                      : getAssetReferenceReference(
                          assets: world.interfaceSoundsAssets,
                          id: sound.id,
                        ).reference,
                  text: e.label,
                ),
                activateCommand == null
                    ? menuItemLabel
                    : Button(
                        () => worldContext.handleCallCommand(
                          callCommand: activateCommand,
                        ),
                      ),
              );
            },
          ).toList(),
          onCancel: () {
            if (customMenu.cancellable) {
              worldContext.game.popLevel(ambianceFadeTime: customMenu.fadeTime);
              final cancelCommand = customMenu.cancelCommand;
              if (cancelCommand != null) {
                worldContext.handleCallCommand(callCommand: cancelCommand);
              }
            }
          },
        );
}
