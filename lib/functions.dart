/// Provides functions used by the library.
library functions;

import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'extensions.dart';
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
      framesPerSecond: world.options.framesPerSecond,
      onStart: () {
        final mainMenuMusicId = world.options.mainMenuMusicId;
        final menuMoveSoundId = world.options.menuMoveSoundId;
        final menuMoveSound = menuMoveSoundId != null
            ? world.interfaceSoundsAssetStore.getAssetReferenceFromVariableName(
                menuMoveSoundId,
              )
            : null;
        final activateSoundId = world.options.menuActivateSoundId;
        final activateSound = activateSoundId != null
            ? world.interfaceSoundsAssetStore
                .getAssetReferenceFromVariableName(activateSoundId)
            : null;
        final creditsMusicId = world.options.creditMusicId;
        final creditsMenu = Menu(
          game: game,
          title: Message(
            text: world.options.creditsMenuTitle,
          ),
          ambiances: [
            if (creditsMusicId != null)
              Ambiance(
                sound: world.musicAssetStore
                    .getAssetReferenceFromVariableName(creditsMusicId),
              )
          ],
          items: [
            for (final credit in world.credits)
              MenuItem(
                  Message(
                    keepAlive: true,
                    sound: credit.assetId == null
                        ? menuMoveSound
                        : world.creditsAssetStore
                            .getAssetReferenceFromVariableName(
                            credit.assetId!,
                          ),
                    text: credit.title,
                  ),
                  Button(
                    () => credit.url == null
                        ? null
                        : game.outputText(credit.url!),
                  ))
          ],
          onCancel: game.popLevel,
        );
        final mainMenu = Menu(
          game: game,
          title: Message(text: world.options.mainMenuTitle),
          ambiances: [
            if (mainMenuMusicId != null)
              Ambiance(
                sound: world.musicAssetStore.getAssetReferenceFromVariableName(
                  mainMenuMusicId,
                ),
              )
          ],
          items: [
            MenuItem(
              Message(
                keepAlive: true,
                sound: menuMoveSound,
                text: world.options.playNewGameMenuItemTitle,
              ),
              Button(
                unimplemented,
                activateSound: activateSound,
              ),
            ),
            MenuItem(
              Message(
                keepAlive: true,
                sound: menuMoveSound,
                text: world.options.playSavedGameMenuItemTitle,
              ),
              Button(
                unimplemented,
                activateSound: activateSound,
              ),
            ),
            MenuItem(
              Message(
                keepAlive: true,
                sound: menuMoveSound,
                text: world.options.creditsMenuItemTitle,
              ),
              Button(
                () => game.pushLevel(creditsMenu),
                activateSound: activateSound,
              ),
            ),
            MenuItem(
              Message(
                keepAlive: true,
                sound: menuMoveSound,
                text: world.options.exitMenuItemTitle,
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
