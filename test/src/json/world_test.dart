import 'package:test/test.dart';
import 'package:worldsmith/constants.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

void main() {
  group(
    'World class',
    () {
      final world = World();
      test(
        'Initialisation',
        () {
          expect(world.credits, isEmpty);
          expect(world.creditsAssets, isEmpty);
          expect(world.creditsMenuMusic, isNull);
          final creditsMenuOptions = world.creditsMenuOptions;
          expect(creditsMenuOptions.fadeTime, 3.0);
          expect(creditsMenuOptions.music, isNull);
          expect(creditsMenuOptions.title, 'Acknowledgements');
          expect(world.directions, defaultDirections);
          expect(world.equipmentAssets, isEmpty);
          expect(world.equipmentPositions, isEmpty);
          final globalOptions = world.globalOptions;
          expect(globalOptions.framesPerSecond, 60);
          expect(world.interfaceSoundsAssets, isEmpty);
          expect(world.mainMenuMusic, isNull);
          final mainMenuOptions = world.mainMenuOptions;
          expect(mainMenuOptions.creditsMessage.text, 'Show Credits');
          expect(mainMenuOptions.exitMessage.text, 'Exit');
          expect(mainMenuOptions.fadeTime, 4.0);
          expect(mainMenuOptions.music, isNull);
          expect(mainMenuOptions.newGameMessage.text, 'Start New Game');
          expect(mainMenuOptions.savedGameMessage.text, 'Play Saved Game');
          expect(mainMenuOptions.title, 'Main Menu');
          expect(world.menuActivateSound, isNull);
          expect(world.menuMoveSound, isNull);
          expect(world.musicAssets, isEmpty);
          final pauseMenuOptions = world.pauseMenuOptions;
          expect(pauseMenuOptions.fadeTime, isNull);
          expect(pauseMenuOptions.music, isNull);
          expect(pauseMenuOptions.returnToGameMessage.text, 'Return To Game');
          expect(pauseMenuOptions.title, 'Pause Menu');
          expect(world.reverbs, isEmpty);
          final soundOptions = world.soundOptions;
          expect(soundOptions.defaultGain, 0.7);
          expect(
              soundOptions.defaultPannerStrategy, DefaultPannerStrategy.stereo);
          expect(soundOptions.menuActivateSound, isNull);
          expect(soundOptions.menuMoveSound, isNull);
          expect(world.terrainAssets, isEmpty);
          expect(world.terrains, isEmpty);
          expect(world.title, 'Untitled World');
          expect(world.zones, isEmpty);
        },
      );
    },
  );
  group(
    'Asset Stores',
    () {
      final world = World(
        creditsAssets: [
          AssetReferenceReference(
            variableName: 'sound1',
            reference: AssetReference.file('something'),
          )
        ],
        equipmentAssets: [
          AssetReferenceReference(
            variableName: 'sword1',
            reference: AssetReference.collection('sword1'),
          )
        ],
        interfaceSoundsAssets: [
          AssetReferenceReference(
            variableName: 'menuActivate',
            reference: AssetReference.file('menuActivate'),
          ),
          AssetReferenceReference(
            variableName: 'menuMove',
            reference: AssetReference.file('menuActivate'),
          )
        ],
        musicAssets: [
          AssetReferenceReference(
            variableName: 'music',
            reference: AssetReference.file('music.mp3'),
          )
        ],
        terrainAssets: [
          AssetReferenceReference(
            variableName: 'grass',
            reference: AssetReference.collection('grass'),
          )
        ],
      );
      test(
        'creditsAssetStore',
        () {
          final store = world.creditsAssetStore;
          expect(store.assets, world.creditsAssets);
          expect(store.comment, 'Credits sounds');
          expect(store.destination, r'assets\credits');
          expect(store.filename, r'assets\credits.dart');
        },
      );
      test(
        'equipmentAssetStore',
        () {
          final store = world.equipmentAssetStore;
          expect(store.assets, world.equipmentAssets);
          expect(store.comment, 'Equipment sounds');
          expect(store.destination, r'assets\equipment');
          expect(store.filename, r'assets\equipment.dart');
        },
      );
      test(
        'interfaceStore',
        () {
          final store = world.interfaceSoundsAssetStore;
          expect(store.assets, world.interfaceSoundsAssets);
          expect(store.comment, 'UI sounds');
          expect(store.destination, r'assets\interface');
          expect(store.filename, r'assets\interface.dart');
        },
      );
      test(
        'musicAssetStore',
        () {
          final store = world.musicAssetStore;
          expect(store.assets, world.musicAssets);
          expect(store.comment, 'Musical assets');
          expect(store.destination, r'assets\music');
          expect(store.filename, r'assets\music.dart');
        },
      );
      test(
        'terrainsAssetStore',
        () {
          final store = world.terrainAssetStore;
          expect(store.assets, world.terrainAssets);
          expect(store.comment, 'Terrain sounds');
          expect(store.destination, r'assets\terrain');
          expect(store.filename, r'assets\terrain.dart');
        },
      );
    },
  );
  group(
    'Command Categories',
    () {
      final command1 = WorldCommand(id: 'command1', name: 'Command 1');
      final command2 = WorldCommand(id: 'command2', name: 'Command 2');
      final command3 = WorldCommand(id: 'command3', name: 'Command 3');
      final category1 = CommandCategory(
        id: 'category1',
        name: 'Category 1',
        commands: [command1],
      );
      final category2 = CommandCategory(
        id: 'category2',
        name: 'Category 2',
        commands: [command2, command3],
      );
      final world = World(commandCategories: [category1, category2]);
      test(
        'World.commands',
        () {
          expect(world.commands, [command1, command2, command3]);
        },
      );
      test(
        'World.getCommand',
        () {
          expect(world.getCommand(command1.id), command1);
          expect(world.getCommand(command2.id), command2);
          expect(world.getCommand(command3.id), command3);
        },
      );
    },
  );
}
