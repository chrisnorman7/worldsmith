import 'package:test/test.dart';
import 'package:worldsmith/functions.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

void main() {
  group(
    'WorldContext class',
    () {
      test(
        'Initialisation',
        () {
          final world = World(title: 'Test WorldContext Class');
          final game = Game(world.title);
          final worldContext = WorldContext(game: game, world: world);
          expect(worldContext.game, game);
          expect(worldContext.world, world);
          expect(worldContext.creditsMenuAmbiances, isEmpty);
          expect(worldContext.creditsMenuBuilder, getCreditsMenu);
          expect(worldContext.mainMenuAmbiances, isEmpty);
          expect(worldContext.mainMenuBuilder, getMainMenu);
          expect(worldContext.pauseMenuAmbiances, isEmpty);
          expect(worldContext.pauseMenuBuilder, getPauseMenu);
          expect(worldContext.zoneMenuBuilder, getZoneLevel);
        },
      );
      test(
        'Ambiances',
        () {
          final mainMenuMusic = AssetReferenceReference(
            variableName: '1',
            reference: AssetReference.file('main_menu.mp3'),
          );
          final creditsMenuMusic = AssetReferenceReference(
            variableName: '2',
            reference: AssetReference.file('credits.mp3'),
          );
          final pauseMusic = AssetReferenceReference(
            variableName: '3',
            reference: AssetReference.file('pause_menu.mp3'),
          );
          final world = World(
            title: 'Ambiances Test',
            musicAssets: [
              mainMenuMusic,
              creditsMenuMusic,
              pauseMusic,
            ],
            mainMenuOptions: MainMenuOptions(
              music: Sound(id: mainMenuMusic.variableName, gain: 1.0),
            ),
            creditsMenuOptions: CreditsMenuOptions(
              music: Sound(id: creditsMenuMusic.variableName, gain: 2.0),
            ),
            pauseMenuOptions: PauseMenuOptions(
              music: Sound(id: pauseMusic.variableName, gain: 3.0),
            ),
          );
          final game = Game(world.title);
          final worldContext = WorldContext(game: game, world: world);
          var ambiance = worldContext.creditsMenuAmbiances.single;
          expect(ambiance.sound, creditsMenuMusic.reference);
          expect(ambiance.gain, 2.0);
          expect(ambiance.position, isNull);
          ambiance = worldContext.mainMenuAmbiances.single;
          expect(ambiance.sound, mainMenuMusic.reference);
          expect(ambiance.gain, 1.0);
          expect(ambiance.position, isNull);
          ambiance = worldContext.pauseMenuAmbiances.single;
          expect(ambiance.sound, pauseMusic.reference);
          expect(ambiance.gain, 3.0);
          expect(ambiance.position, isNull);
        },
      );
    },
  );
}
