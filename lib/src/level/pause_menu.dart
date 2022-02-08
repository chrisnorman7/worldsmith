/// Provides the [PauseMenu] class.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../extensions.dart';
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
            if (world.pauseMenuOptions.musicId != null)
              Ambiance(
                  sound: world.musicAssetStore
                      .getAssetReferenceFromVariableName(
                          world.pauseMenuOptions.musicId)!),
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
