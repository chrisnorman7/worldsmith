/// Provides functions used by the library.
library functions;

import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'src/functions/get_credits_menu.dart';
import 'src/json/world.dart';

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
  void unimplemented() => game.outputText('Unimplemented.');
  try {
    await game.run(
      sdl,
      framesPerSecond: world.globalOptions.framesPerSecond,
      onStart: () {
        final mainMenuMusic = world.mainMenuMusic;
        final moveSound = world.menuMoveSound;
        final activateSound = world.menuActivateSound;
        final mainMenu = Menu(
          game: game,
          title: Message(text: world.mainMenuOptions.options.title),
          ambiances: [
            if (mainMenuMusic != null) Ambiance(sound: mainMenuMusic)
          ],
          items: [
            MenuItem(
              Message(
                keepAlive: true,
                sound: moveSound,
                text: world.mainMenuOptions.newGameTitle,
              ),
              Button(
                unimplemented,
                activateSound: activateSound,
              ),
            ),
            MenuItem(
              Message(
                keepAlive: true,
                sound: moveSound,
                text: world.mainMenuOptions.savedGameTitle,
              ),
              Button(
                unimplemented,
                activateSound: activateSound,
              ),
            ),
            if (world.credits.isNotEmpty)
              MenuItem(
                Message(
                  keepAlive: true,
                  sound: moveSound,
                  text: world.mainMenuOptions.creditsTitle,
                ),
                Button(
                  () => game.pushLevel(
                    getCreditsMenu(
                      game: game,
                      world: world,
                    ),
                  ),
                  activateSound: activateSound,
                ),
              ),
            MenuItem(
              Message(
                keepAlive: true,
                sound: moveSound,
                text: world.mainMenuOptions.exitTitle,
              ),
              Button(game.stop, activateSound: activateSound),
            )
          ],
        );
        game.pushLevel(mainMenu);
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
