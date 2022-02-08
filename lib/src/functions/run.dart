/// Provides runner methods.
import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import '../json/world.dart';
import 'get_main_menu.dart';

/// Run the given [world].
Future<void> runWorld(World world) async {
  final synthizer = Synthizer()..initialize();
  final context = synthizer.createContext();
  final game = Game(world.title);
  final soundManager = SoundManager(
    game: game,
    context: context,
    bufferCache: BufferCache(
      synthizer: context.synthizer,
      maxSize: pow(1024, 3).floor(),
      random: game.random,
    ),
  );
  game.sounds.listen(soundManager.handleEvent);
  final sdl = Sdl()..init();
  try {
    await game.run(
      sdl,
      framesPerSecond: world.globalOptions.framesPerSecond,
      onStart: () {
        game.pushLevel(
          getMainMenu(game: game, world: world),
        );
      },
    );
  } catch (e) {
    rethrow;
  } finally {
    context.destroy();
    synthizer.shutdown();
    sdl.quit();
  }
}
