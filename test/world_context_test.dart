import 'dart:convert';
import 'dart:io';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:worldsmith/constants.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'pond_zone.dart';

const orgName = 'com.test';
const appName = 'test_game';

final worldFile = File('world.json');
final worldFileEncrypted = File(encryptedWorldFilename + '.test');

class _WorksException implements Exception {}

/// Save the given [world].
void saveWorld(World world) {
  final data = jsonEncode(world.toJson());
  worldFile.writeAsStringSync(data);
}

class _ButtonException implements Exception {}

void main() {
  final sdl = Sdl();
  final game = Game('Test Game');
  group(
    'WorldContext class',
    () {
      final world = World(
        globalOptions: WorldOptions(
          appName: appName,
          orgName: orgName,
        ),
      );
      final worldContext = WorldContext(
        sdl: sdl,
        game: game,
        world: world,
      );
      final directory = Directory(
        sdl.getPrefPath(orgName, appName),
      );
      tearDownAll(
        () {
          if (directory.existsSync() == true) {
            directory.deleteSync(recursive: true);
          }
        },
      );
      test(
        'Initialisation',
        () {
          final world = World(
            title: 'Test WorldContext Class',
            globalOptions: WorldOptions(
              appName: appName,
              orgName: orgName,
            ),
          );
          final game = Game(world.title);
          final worldContext = WorldContext(sdl: sdl, game: game, world: world);
          expect(worldContext.sdl, sdl);
          expect(worldContext.game, game);
          expect(worldContext.world, world);
          expect(worldContext.customCommands, isEmpty);
          expect(worldContext.conditionalFunctions, isEmpty);
          expect(
            worldContext.preferencesDirectory,
            sdl.getPrefPath(
              orgName,
              appName,
            ),
          );
          expect(worldContext.errorHandler, isNull);
        },
      );
      test(
        '.playerPreference',
        () {
          expect(
            worldContext.playerPreferencesFile.path,
            path.join(directory.path, preferencesFilename),
          );
          if (worldContext.playerPreferencesFile.existsSync()) {
            worldContext.playerPreferencesFile.deleteSync(recursive: true);
          }
          expect(worldContext.playerPreferencesFile.existsSync(), isFalse);
          final defaultPrefs = world.defaultPlayerPreferences;
          final prefs = worldContext.playerPreferences;
          expect(prefs.ambianceGain, defaultPrefs.ambianceGain);
          expect(prefs.interfaceSoundsGain, defaultPrefs.interfaceSoundsGain);
          expect(prefs.musicGain, defaultPrefs.musicGain);
          expect(prefs.pannerStrategy, defaultPrefs.pannerStrategy);
          expect(prefs.questStages, isEmpty);
          expect(prefs.turnSensitivity, defaultPrefs.turnSensitivity);
          prefs.ambianceGain *= 2;
          expect(prefs.ambianceGain, defaultPrefs.ambianceGain * 2);
        },
      );
      test(
        '.triggerMapFile',
        () {
          expect(
            worldContext.triggerMapFile.path,
            path.join(
              worldContext.preferencesDirectory,
              triggerMapFilename,
            ),
          );
        },
      );
      test(
        '.savePlayerPreferences',
        () {
          if (worldContext.playerPreferencesFile.existsSync()) {
            worldContext.playerPreferencesFile.deleteSync(recursive: true);
          }
          final prefs = worldContext.playerPreferences
            ..ambianceGain *= 2
            ..interfaceSoundsGain *= 3
            ..musicGain *= 3;
          worldContext.savePlayerPreferences();
          expect(worldContext.playerPreferencesFile.existsSync(), isTrue);
          final data = worldContext.playerPreferencesFile.readAsStringSync();
          final json = jsonDecode(data) as JsonType;
          final prefs2 = PlayerPreferences.fromJson(json);
          expect(prefs2.ambianceGain, prefs.ambianceGain);
          expect(prefs2.interfaceSoundsGain, prefs.interfaceSoundsGain);
          expect(prefs2.musicGain, prefs.musicGain);
        },
      );
      test(
        '.getMenuItemMessage',
        () {
          final world = World();
          final game = Game(world.title);
          final worldContext = WorldContext(sdl: sdl, game: game, world: world);
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
          final worldContext = WorldContext(sdl: sdl, game: game, world: world);
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
        '.getAssetStore',
        () {
          final world = World();
          final worldContext = WorldContext(
            sdl: sdl,
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
      test(
        '.getCustomSound',
        () {
          final ambiance = AssetReference.file('ambiance.wav');
          final ambianceReference = AssetReferenceReference(
            variableName: 'ambiance',
            reference: ambiance,
          );
          final terrain = AssetReference.collection('grass');
          final terrainReference = AssetReferenceReference(
            variableName: 'terrain',
            reference: terrain,
          );
          final world = World(
            ambianceAssets: [ambianceReference],
            terrainAssets: [terrainReference],
          );
          final worldContext = WorldContext(
            sdl: sdl,
            game: game,
            world: world,
          );
          expect(
            worldContext.getCustomSound(CustomSound(
              assetStore: CustomSoundAssetStore.ambiances,
              id: ambianceReference.variableName,
            )),
            ambiance,
          );
          expect(
            worldContext.getCustomSound(
              CustomSound(
                assetStore: CustomSoundAssetStore.terrain,
                id: terrainReference.variableName,
              ),
            ),
            terrain,
          );
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
            sdl: sdl,
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
        '.getButton',
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
          final worldContext = WorldContext(sdl: sdl, game: game, world: world);
          final button = worldContext.getButton(() {
            throw _ButtonException();
          });
          expect(button.activateSound, activateSound.reference);
          expect(button.onActivate, isNotNull);
          expect(() => button.onActivate!(), throwsA(isA<_ButtonException>()));
        },
      );
      test(
        '.getMainMenu',
        () {
          final menu = worldContext.getMainMenu();
          expect(menu.worldContext, worldContext);
        },
      );
      test(
        '.getCreditsMenu',
        () {
          final menu = worldContext.getCreditsMenu();
          expect(menu, isA<CreditsMenu>());
        },
      );
      test(
        '.getSoundOptionsMenu',
        () {
          final menu = worldContext.getSoundOptionsMenu();
          expect(menu.worldContext, worldContext);
        },
      );
      test(
        '.getZoneLevel',
        () {
          final pondZone = PondZone.generate();
          final zone = pondZone.zone;
          final world = World(zones: [zone]);
          pondZone.generateTerrains(world);
          final worldContext = WorldContext(sdl: sdl, game: game, world: world);
          final level = worldContext.getZoneLevel(zone);
          expect(level.worldContext, worldContext);
          expect(level.zone, zone);
        },
      );
      test(
        '.getPauseMenu',
        () {
          final pondZone = PondZone.generate();
          final zone = pondZone.zone;
          final world = World(zones: [zone]);
          final worldContext = WorldContext(sdl: sdl, game: game, world: world);
          final menu = worldContext.getPauseMenu(zone);
          expect(menu.worldContext, worldContext);
          expect(menu.zone, zone);
        },
      );
      test(
        '.getQuestMenu',
        () {
          final menu = worldContext.getQuestMenu();
          expect(menu.worldContext, worldContext);
        },
      );
      test(
        '.getSceneLevel',
        () {
          final command = WorldCommand(id: 'command1', name: 'First Command');
          final scene = Scene(
            id: 'scene1',
            name: 'First Scene',
            sections: [],
          );
          final world = World(
            scenes: [scene],
            commandCategories: [
              CommandCategory(
                id: 'category1',
                name: 'First Command Category',
                commands: [command],
              ),
            ],
          );
          final worldContext = WorldContext(sdl: sdl, game: game, world: world);
          var level = worldContext.getSceneLevel(scene: scene);
          expect(level.callCommand, isNull);
          expect(level.index, isZero);
          expect(level.scene, scene);
          expect(level.sound, isNull);
          expect(level.worldContext, worldContext);
          final callCommand = CallCommand(commandId: command.id);
          level = worldContext.getSceneLevel(
            scene: scene,
            callCommand: callCommand,
          );
          expect(level.callCommand, callCommand);
          expect(level.index, isZero);
          expect(level.scene, scene);
          expect(level.sound, isNull);
          expect(level.worldContext, worldContext);
        },
      );
      test(
        '.getConversationLevel',
        () {
          final response = ConversationResponse(id: 'response1');
          final branch =
              ConversationBranch(id: 'branch1', responseIds: [response.id]);
          final conversation = Conversation(
            id: 'conversation1',
            name: 'First Conversation',
            branches: [branch],
            initialBranchId: branch.id,
            responses: [response],
          );
          final world = World(
            conversationCategories: [
              ConversationCategory(
                id: 'category1',
                name: 'First Category',
                conversations: [conversation],
              )
            ],
          );
          final worldContext = WorldContext(sdl: sdl, game: game, world: world);
          const fadeTime = 12345;
          final level = worldContext.getConversationLevel(
            conversation: conversation,
            fadeTime: fadeTime,
          );
          expect(level.branch, isNull);
          expect(level.conversation, conversation);
          expect(level.fadeTime, fadeTime);
          expect(level.reverb, isNull);
          expect(level.soundChannel, isNull);
          expect(level.worldContext, worldContext);
        },
      );
      test(
        '.getWorldJsonString',
        () {
          final zone = PondZone.generate().zone;
          final world = World(zones: [zone]);
          final worldContext = WorldContext(sdl: sdl, game: game, world: world);
          expect(
            worldContext.getWorldJsonString(compact: false),
            indentedJsonEncoder.convert(world),
          );
          expect(
            worldContext.getWorldJsonString(),
            jsonEncode(world),
          );
        },
      );
    },
  );
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
          final worldContext = WorldContext(sdl: sdl, game: game, world: world);
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
  group(
    'Save Functions',
    () {
      final zone = PondZone.generate().zone;
      final world = World(zones: [zone]);
      final worldContext = WorldContext(sdl: sdl, game: game, world: world);
      final file = File(encryptedWorldFilename);
      tearDown(
        () {
          if (file.existsSync()) {
            file.deleteSync(recursive: true);
          }
        },
      );
      test(
        '.saveEncrypted',
        () {
          final encryptionKey = worldContext.saveEncrypted();
          expect(encryptionKey, isA<String>());
          expect(file.existsSync(), isTrue);
          final world2 = World.loadEncrypted(encryptionKey: encryptionKey);
          expect(world2.zones.length, 1);
          final json1 = world.toJson();
          final json2 = world2.toJson();
          expect(jsonEncode(json1), jsonEncode(json2));
        },
      );
    },
  );
  group(
    'Handle Commands',
    () {
      final command1 = WorldCommand(id: 'command1', name: 'Command 1');
      final command2 = WorldCommand(id: 'command2', name: 'Command 2');
      final category1 = CommandCategory(
        id: 'category1',
        name: 'Category 1',
        commands: [command1],
      );
      final category2 = CommandCategory(
        id: 'category2',
        name: 'Category 2',
        commands: [command2],
      );
      final pondZone = PondZone.generate();
      final zone = pondZone.zone;
      for (final box in zone.boxes) {
        zone.locationMarkers.add(
          LocationMarker(
            id: 'marker_${box.id}',
            message: CustomMessage(text: 'Box ${box.name}'),
            coordinates: Coordinates(
              0,
              0,
              clamp: CoordinateClamp(
                boxId: box.id,
                corner: BoxCorner.southwest,
              ),
            ),
          ),
        );
      }
      final world = World(
        commandCategories: [category1, category2],
        zones: [zone],
      );
      pondZone.generateTerrains(world);
      const commandName = 'testing';
      final worldContext = WorldContext(
        sdl: sdl,
        game: game,
        world: world,
        customCommands: {commandName: (context) => throw _WorksException()},
      );
      test(
        'Detect command loops',
        () {
          command2.callCommands.add(CallCommand(commandId: command1.id));
          command1.callCommands.add(CallCommand(commandId: command2.id));
          expect(
            () => worldContext.runCommand(command: command1),
            throwsA(isA<UnsupportedError>()),
          );
        },
      );
      test(
        '.handleLocalTeleport',
        () {
          final level = worldContext.getZoneLevel(zone)..onPush();
          expect(level.heading, isZero);
          expect(level.coordinates.x, isZero);
          expect(level.coordinates.y, isZero);
          for (var i = 0; i < zone.locationMarkers.length; i++) {
            final box = zone.boxes[i];
            final marker = zone.locationMarkers[i];
            final boxCoordinates = zone.getAbsoluteCoordinates(box.start);
            final markerCoordinates = zone.getAbsoluteCoordinates(
              marker.coordinates,
            );
            expect(boxCoordinates.x, markerCoordinates.x);
            expect(boxCoordinates.y, markerCoordinates.y);
            final localTeleport = LocalTeleport(
              locationMarkerId: marker.id,
              heading: game.random.nextInt(360),
            );
            worldContext.handleLocalTeleport(
              localTeleport: localTeleport,
              zoneLevel: level,
            );
            expect(level.heading, localTeleport.heading);
            expect(
              level.coordinates.x,
              markerCoordinates.x + level.coordinatesOffset.x,
            );
            expect(
              level.coordinates.y,
              markerCoordinates.y + level.coordinatesOffset.y,
            );
          }
        },
      );
      test(
        '.handleWalkingMode',
        () {
          final level = worldContext.getZoneLevel(zone);
          expect(level.currentWalkingOptions, isNull);
          expect(level.walkingMode, WalkingMode.stationary);
          worldContext.handleWalkingMode(
            walkingMode: WalkingMode.fast,
            zoneLevel: level,
          );
          expect(level.currentWalkingOptions, level.currentTerrain.fastWalk);
          expect(level.walkingMode, WalkingMode.fast);
          worldContext.handleWalkingMode(
            walkingMode: WalkingMode.slow,
            zoneLevel: level,
          );
          expect(level.currentWalkingOptions, level.currentTerrain.slowWalk);
          expect(level.walkingMode, WalkingMode.slow);
          worldContext.handleWalkingMode(
            walkingMode: WalkingMode.stationary,
            zoneLevel: level,
          );
          expect(level.currentWalkingOptions, isNull);
          expect(level.walkingMode, WalkingMode.stationary);
        },
      );
      test(
        '.handleZoneTeleport',
        () {
          var zoneTeleport = ZoneTeleport(
            zoneId: zone.id,
            minCoordinates: Coordinates(1, 2),
            heading: 90,
          );
          final menu = worldContext.getMainMenu();
          game.pushLevel(menu);
          expect(game.currentLevel, menu);
          worldContext.handleZoneTeleport(zoneTeleport: zoneTeleport);
          var level = game.currentLevel;
          expect(level, isA<ZoneLevel>());
          level as ZoneLevel;
          expect(level.coordinates.x, zoneTeleport.minCoordinates.x);
          expect(level.coordinates.y, zoneTeleport.minCoordinates.y);
          expect(level.heading, zoneTeleport.heading);
          expect(level.worldContext, worldContext);
          expect(level.zone, zone);
          // Check that popping the level doesn't reveal the main menu or
          // anything.
          game.popLevel();
          expect(game.currentLevel, isNull);
          zoneTeleport = ZoneTeleport(
            zoneId: zone.id,
            minCoordinates: Coordinates(0, 0),
            heading: 45,
            maxCoordinates: Coordinates(10, 10),
          );
          worldContext.handleZoneTeleport(zoneTeleport: zoneTeleport);
          level = game.currentLevel as ZoneLevel;
          expect(
            level.coordinates.x,
            inInclusiveRange(
              zoneTeleport.minCoordinates.x,
              zoneTeleport.maxCoordinates!.x,
            ),
          );
          expect(
            level.coordinates.y,
            inInclusiveRange(
              zoneTeleport.minCoordinates.y,
              zoneTeleport.maxCoordinates!.y,
            ),
          );
          expect(level.heading, zoneTeleport.heading);
        },
      );
      test(
        '.handleCustomCommandName',
        () {
          expect(
            () => worldContext.handleCustomCommandName('hello world'),
            throwsA(isA<UnimplementedError>()),
          );
          expect(
            () => worldContext.handleCustomCommandName(commandName),
            throwsA(isA<_WorksException>()),
          );
        },
      );
      test(
        '.handleStartConversation',
        () {
          expect(world.conversationCategories, isNotEmpty);
        },
      );
    },
  );
}
