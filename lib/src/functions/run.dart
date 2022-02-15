import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import '../../constants.dart';
import '../../world_context.dart';

/// Run the given [worldContext].
///
/// If [sdl] is not `null`, then it should call [Sdl.init] itself.
Future<void> runWorld(
  WorldContext worldContext, {
  Sdl? sdl,
  EventCallback<SoundEvent>? onSound,
}) async {
  Synthizer? synthizer;
  Context? context;
  if (onSound == null) {
    synthizer = Synthizer()..initialize();
    context = synthizer.createContext();
    final soundManager = SoundManager(
      game: worldContext.game,
      context: context,
      bufferCache: BufferCache(
        synthizer: context.synthizer,
        maxSize: pow(1024, 3).floor(),
        random: worldContext.game.random,
      ),
    );
    onSound = soundManager.handleEvent;
  }
  worldContext.game.sounds.listen(onSound);
  sdl ??= Sdl()..init();
  try {
    await worldContext.game.run(
      sdl,
      framesPerSecond: worldContext.world.globalOptions.framesPerSecond,
      onStart: () => worldContext.game
        ..setDefaultPannerStrategy(
            worldContext.world.soundOptions.defaultPannerStrategy)
        ..pushLevel(
          worldContext.mainMenuBuilder(worldContext),
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
