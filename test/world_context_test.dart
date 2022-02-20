import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:worldsmith/constants.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

final worldFile = File('world.json');
final worldFileEncrypted = File(encryptedWorldFilename + '.test');

/// Save the given [world].
void saveWorld(World world) {
  final data = jsonEncode(world.toJson());
  worldFile.writeAsStringSync(data);
}

class _ButtonException implements Exception {}

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
          expect(worldContext.mainMenuAmbiances, isEmpty);
          expect(worldContext.pauseMenuAmbiances, isEmpty);
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
      test(
        '.getMenuItemMessage',
        () {
          final world = World();
          final game = Game(world.title);
          final worldContext = WorldContext(game: game, world: world);
          var message = worldContext.getMenuItemMessage(text: 'Testing');
          expect(message.text, 'Testing');
          expect(message.gain, world.soundOptions.defaultGain);
          expect(message.keepAlive, isTrue);
          expect(message.sound, isNull);
          final reference = AssetReferenceReference(
            variableName: 'move',
            reference: AssetReference.file('menu_move.mp3'),
          );
          world
            ..interfaceSoundsAssets.add(reference)
            ..soundOptions.menuMoveSound =
                Sound(id: reference.variableName, gain: 4.0);
          message = worldContext.getMenuItemMessage(text: 'Sound now');
          expect(message.gain, 4.0);
          expect(message.keepAlive, isTrue);
          expect(message.sound, reference.reference);
          expect(message.text, 'Sound now');
        },
      );
      test(
        '.getSoundMessage',
        () {
          final reference1 = AssetReferenceReference(
            variableName: '1',
            reference: AssetReference.file('1.mp3'),
          );
          final reference2 = AssetReferenceReference(
            variableName: '2',
            reference: AssetReference.file('2.mp3'),
          );
          final world = World(interfaceSoundsAssets: [reference1, reference2]);
          final game = Game(world.title);
          final worldContext = WorldContext(game: game, world: world);
          var message = worldContext.getSoundMessage(
            sound: Sound(id: reference1.variableName, gain: 2.0),
            assets: world.interfaceSoundsAssets,
            text: 'Testing 1',
          );
          expect(message.gain, 2.0);
          expect(message.keepAlive, isFalse);
          expect(message.sound, reference1.reference);
          expect(message.text, 'Testing 1');
          message = worldContext.getSoundMessage(
            sound: Sound(id: reference2.variableName, gain: 5.0),
            assets: world.interfaceSoundsAssets,
            text: 'Testing 2',
            keepAlive: true,
          );
          expect(message.gain, 5.0);
          expect(message.keepAlive, isTrue);
          expect(message.sound, reference2.reference);
          expect(message.text, 'Testing 2');
        },
      );
      test(
        'getButton',
        () {
          final activateSound = AssetReferenceReference(
            variableName: 'activate',
            reference: AssetReference.file('activate.mp3'),
          );
          final moveSound = AssetReferenceReference(
            variableName: 'move',
            reference: AssetReference.file('activate.mp3'),
          );
          final world = World(
            interfaceSoundsAssets: [activateSound, moveSound],
            soundOptions: SoundOptions(
              menuActivateSound: Sound(
                id: activateSound.variableName,
                gain: 3.0,
              ),
              menuMoveSound: Sound(id: moveSound.variableName, gain: 5.0),
            ),
          );
          final game = Game(world.title);
          final worldContext = WorldContext(game: game, world: world);
          final button = worldContext.getButton(() {
            throw _ButtonException();
          });
          expect(button.activateSound, activateSound.reference);
          expect(button.onActivate, isNotNull);
          expect(() => button.onActivate!(), throwsA(isA<_ButtonException>()));
        },
      );
      test(
        '.getCustomMessage',
        () {
          final assetReferenceReference = AssetReferenceReference(
            variableName: 'testing',
            reference: AssetReference('testing.wav', AssetType.file),
          );
          final sound = CustomSound(
            assetStore: CustomSoundAssetStore.interface,
            id: assetReferenceReference.variableName,
            gain: 1.0,
          );
          final customMessage = CustomMessage(
            sound: sound,
            text: 'I love {action_1} {action_2}.',
          );
          final worldContext = WorldContext(
            game: Game('Custom Message'),
            world: World(interfaceSoundsAssets: [assetReferenceReference]),
          );
          final message = worldContext.getCustomMessage(
            customMessage,
            replacements: {'action_1': 'writing', 'action_2': 'tests'},
          );
          expect(message.gain, sound.gain);
          expect(message.keepAlive, isFalse);
          expect(message.sound, assetReferenceReference.reference);
          expect(message.text, 'I love writing tests.');
        },
      );
      test(
        '.getAssetStore',
        () {
          final world = World();
          final worldContext = WorldContext(
            game: Game('Test asset stores'),
            world: world,
          );
          expect(
            worldContext.getAssetStore(CustomSoundAssetStore.credits).assets,
            world.creditsAssets,
          );
          expect(
            worldContext.getAssetStore(CustomSoundAssetStore.equipment).assets,
            world.equipmentAssets,
          );
          expect(
            worldContext.getAssetStore(CustomSoundAssetStore.interface).assets,
            world.interfaceSoundsAssets,
          );
          expect(
            worldContext.getAssetStore(CustomSoundAssetStore.music).assets,
            world.musicAssets,
          );
          expect(
            worldContext.getAssetStore(CustomSoundAssetStore.terrain).assets,
            world.terrainAssets,
          );
        },
      );
    },
  );
  final game = Game('Load Tests');
  group(
    'Load function tests',
    () {
      final world = World(title: 'Load Function Test World');
      tearDown(
        () {
          if (worldFile.existsSync()) {
            worldFile.deleteSync(recursive: true);
          }
          if (worldFileEncrypted.existsSync()) {
            worldFileEncrypted.deleteSync(recursive: true);
          }
        },
      );
      test(
        'loadString',
        () {
          saveWorld(world);
          expect(worldFile.existsSync(), isTrue);
          final loadedWorld = World.fromString(worldFile.readAsStringSync());
          expect(loadedWorld.title, world.title);
        },
      );
      test(
        'loadEncryptedString',
        () {
          final world = World(title: 'Encrypted World');
          final worldContext = WorldContext(game: game, world: world);
          final encryptionKey = worldContext.saveEncrypted(
            filename: worldFileEncrypted.path,
          );
          expect(encryptionKey, isNotEmpty);
          final loadedWorld = World.loadEncrypted(
            encryptionKey: encryptionKey,
            filename: worldFileEncrypted.path,
          );
          expect(loadedWorld.title, world.title);
        },
      );
    },
  );
}
