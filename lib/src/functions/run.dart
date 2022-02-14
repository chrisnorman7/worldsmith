import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import '../../command_triggers.dart';
import '../../constants.dart';
import '../json/world.dart';
import 'get_main_menu.dart';

/// Run the given [world].
Future<void> runWorld(
  World world, {
  EventCallback<SoundEvent>? onSound,
}) async {
  final game = Game(
    world.title,
    triggerMap: TriggerMap(
      [
        walkForwardsCommandTrigger,
        walkBackwardsCommandTrigger,
        sidestepLeftCommandTrigger,
        sidestepRightCommandTrigger,
        turnLeftCommandTrigger,
        turnRightCommandTrigger,
        pauseMenuCommandTrigger,
        showCoordinatesCommandTrigger,
        showFacingCommandTrigger,
      ],
    ),
  );
  Synthizer? synthizer;
  Context? context;
  if (onSound == null) {
    synthizer = Synthizer()..initialize();
    context = synthizer.createContext();
    final soundManager = SoundManager(
      game: game,
      context: context,
      bufferCache: BufferCache(
        synthizer: context.synthizer,
        maxSize: pow(1024, 3).floor(),
        random: game.random,
      ),
    );
    onSound = soundManager.handleEvent;
  }
  game.sounds.listen(onSound);
  final sdl = Sdl()..init();
  try {
    await game.run(
      sdl,
      framesPerSecond: world.globalOptions.framesPerSecond,
      onStart: () => game
        ..setDefaultPannerStrategy(world.soundOptions.defaultPannerStrategy)
        ..pushLevel(
          getMainMenu(game: game, world: world),
        ),
    );
  } catch (e) {
    rethrow;
  } finally {
    context?.destroy();
    synthizer?.shutdown();
    sdl.quit();
  }
}
