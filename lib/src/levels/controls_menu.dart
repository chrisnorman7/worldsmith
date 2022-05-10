// ignore_for_file: prefer_final_parameters
/// Provides the [ControlsMenu] and [ControlMenu] classes.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../util.dart';
import '../../world_context.dart';
import '../json/options/controls_menu_options.dart';

/// A menu to show a single [CommandTrigger] instance.
class ControlMenu extends Menu {
  /// Create an instance.
  ControlMenu({
    required super.game,
    required final CommandTrigger trigger,
    required final ControlsMenuOptions options,
  }) : super(
          title: Message(text: options.title),
          items: [
            MenuItem(
              Message(
                text: options.gameControllerButtonPrefix +
                    (trigger.button?.name ??
                        options.emptyGameControllerButtonMessage),
              ),
              menuItemLabel,
            ),
            MenuItem(
              Message(
                text: options.keyboardControlPrefix +
                    (trigger.keyboardKey?.toPrintableString() ??
                        options.emptyKeyboardControlMessage),
              ),
              menuItemLabel,
            )
          ],
          onCancel: game.popLevel,
        );
}

/// A menu to show game controls.
class ControlsMenu extends Menu {
  /// Create an instance.
  ControlsMenu({required final WorldContext worldContext})
      : super(
          game: worldContext.game,
          title: Message(
            text: worldContext.world.controlsMenuOptions.title,
          ),
          ambiances: [
            if (worldContext.world.controlsMenuOptions.music != null)
              Ambiance(
                sound: getAssetReferenceReference(
                  assets: worldContext.world.musicAssets,
                  id: worldContext.world.controlsMenuOptions.music!.id,
                ).reference,
                gain: worldContext.world.controlsMenuOptions.music!.gain,
              )
          ],
          items: worldContext.world.defaultCommandTriggers.map<MenuItem>((e) {
            final controlsMenuOptions = worldContext.world.controlsMenuOptions;
            return MenuItem(
              worldContext.getMenuItemMessage(
                sound: controlsMenuOptions.itemSound,
                text: e.description,
              ),
              worldContext.getButton(
                () => worldContext.game.pushLevel(
                  ControlMenu(
                    game: worldContext.game,
                    trigger: e,
                    options: controlsMenuOptions,
                  ),
                ),
              ),
            );
          }).toList(),
          onCancel: () => worldContext
            ..playMenuCancelSound()
            ..game.replaceLevel(
              worldContext.getMainMenu(),
              ambianceFadeTime:
                  worldContext.world.controlsMenuOptions.ambianceFadeTime,
            ),
        );
}
