import 'dart:convert';
import 'dart:io';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:test/test.dart';
import 'package:worldsmith/constants.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'pond_zone.dart';

const orgName = 'com.test';
const appName = 'test_game';

final worldFile = File('world.json');
final worldFileEncrypted = File('$encryptedWorldFilename.test');

class _WorksException implements Exception {}

/// Save the given [world].
void saveWorld(final World world) {
  final data = jsonEncode(world.toJson());
  worldFile.writeAsStringSync(data);
}

class _ButtonException implements Exception {}

void main() {
  final sdl = Sdl();
  final game = Game(
    title: 'Test Game',
    sdl: sdl,
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
        game: game,
        world: world,
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
          final game = Game(
            title: world.title,
            sdl: sdl,
          );
          final worldContext = WorldContext(
            game: game,
            world: world,
          );
          expect(worldContext.game, game);
          expect(worldContext.world, world);
          expect(worldContext.customCommands, isEmpty);
          expect(worldContext.conditionalFunctions, isEmpty);
          expect(worldContext.errorHandler, isNull);
        },
      );
      test(
        '.playerPreference',
        () {
          final file = game.preferencesFile;
          if (file.existsSync()) {
            file.deleteSync(recursive: true);
          }
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
        () {},
      );
      test(
        '.savePlayerPreferences',
        () {
          final prefs = worldContext.playerPreferences
            ..ambianceGain *= 2
            ..interfaceSoundsGain *= 3
            ..musicGain *= 3;
          worldContext.savePlayerPreferences();
          expect(game, worldContext.game);
          expect(
            game.preferences.get<JsonType>(worldsmithGamePreferencesKey),
            isNotNull,
          );
          expect(game.preferencesFile.existsSync(), true);
          final json = game.preferences.get<JsonType>(
            worldsmithGamePreferencesKey,
          )!;
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
          final game = Game(
            title: world.title,
            sdl: sdl,
          );
          final worldContext = WorldContext(
            game: game,
            world: world,
          );
          var message = worldContext.getMenuItemMessage(text: 'Testing');
          expect(message.text, 'Testing');
          expect(message.gain, world.soundOptions.defaultGain);
          expect(message.keepAlive, isTrue);
          expect(message.sound, isNull);
          const reference = AssetReferenceReference(
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
          const reference1 = AssetReferenceReference(
            variableName: '1',
            reference: AssetReference.file('1.mp3'),
          );
          const reference2 = AssetReferenceReference(
            variableName: '2',
            reference: AssetReference.file('2.mp3'),
          );
          final world = World(interfaceSoundsAssets: [reference1, reference2]);
          final game = Game(
            title: world.title,
            sdl: sdl,
          );
          final worldContext = WorldContext(
            game: game,
            world: world,
          );
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
            game: Game(
              title: 'Test asset stores',
              sdl: sdl,
            ),
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
          const ambiance = AssetReference.file('ambiance.wav');
          const ambianceReference = AssetReferenceReference(
            variableName: 'ambiance',
            reference: ambiance,
          );
          const terrain = AssetReference.collection('grass');
          const terrainReference = AssetReferenceReference(
            variableName: 'terrain',
            reference: terrain,
          );
          final world = World(
            ambianceAssets: [ambianceReference],
            terrainAssets: [terrainReference],
          );
          final worldContext = WorldContext(
            game: game,
            world: world,
          );
          expect(
            worldContext.getCustomSound(
              CustomSound(
                assetStore: CustomSoundAssetStore.ambiances,
                id: ambianceReference.variableName,
              ),
            ),
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
          const assetReferenceReference = AssetReferenceReference(
            variableName: 'testing',
            reference: AssetReference('testing.wav', AssetType.file),
          );
          final sound = CustomSound(
            assetStore: CustomSoundAssetStore.interface,
            id: assetReferenceReference.variableName,
            gain: 1.0,
          );
          final worldContext = WorldContext(
            game: Game(
              title: 'Custom Message',
              sdl: sdl,
            ),
            world: World(interfaceSoundsAssets: [assetReferenceReference]),
          );
          final message = worldContext.getCustomMessage(
            message: 'I love {action_1} {action_2}.',
            replacements: {'action_1': 'writing', 'action_2': 'tests'},
            gain: sound.gain,
            sound: assetReferenceReference.reference,
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
          const activateSound = AssetReferenceReference(
            variableName: 'activate',
            reference: AssetReference.file('activate.mp3'),
          );
          const moveSound = AssetReferenceReference(
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
          final game = Game(
            title: world.title,
            sdl: sdl,
          );
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
          final worldContext = WorldContext(
            game: game,
            world: world,
          );
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
          final worldContext = WorldContext(
            game: game,
            world: world,
          );
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
          final worldContext = WorldContext(
            game: game,
            world: world,
          );
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
          final worldContext = WorldContext(
            game: game,
            world: world,
          );
          const fadeTime = 12345;
          final level = worldContext.getConversationLevel(
            conversation: conversation,
            pushInitialBranchAfter: 14,
            fadeTime: fadeTime,
          );
          expect(level.branch, isNull);
          expect(level.pushInitialBranchAfter, 14);
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
          final worldContext = WorldContext(
            game: game,
            world: world,
          );
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
      test(
        '.playerStats',
        () {
          final str = WorldStat(id: 'str', name: 'Strength');
          final dex = WorldStat(id: 'dex', name: 'Dexterity');
          final world = World(stats: [str, dex]);
          final worldContext = WorldContext(
            game: game,
            world: world,
          );
          final stats = worldContext.playerStats;
          expect(stats.getStat(str), str.defaultValue);
          expect(stats.getStat(dex), dex.defaultValue);
          worldContext.playerPreferences.stats[str.id] = 1234;
          expect(
            stats.getStat(str),
            worldContext.playerPreferences.stats[str.id],
          );
          expect(stats.getStat(dex), dex.defaultValue);
        },
      );
      test(
        '.getReverb',
        () {
          const reverbPreset = ReverbPreset(name: 'Test Reverb');
          final reverbPresetReference = ReverbPresetReference(
            id: 'reverb',
            reverbPreset: reverbPreset,
          );
          world.reverbs.add(reverbPresetReference);
          expect(
            identical(
              reverbPresetReference,
              world.getReverbPresetReference(reverbPresetReference.id),
            ),
            isTrue,
          );
          expect(
            worldContext.getReverb(reverbPresetReference),
            isA<CreateReverb>(),
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
          final worldContext = WorldContext(
            game: game,
            world: world,
          );
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
      final worldContext = WorldContext(
        game: game,
        world: world,
      );
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
            name: 'Box ${box.name}',
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
        game: game,
        world: world,
        customCommands: {
          commandName: (final context) => throw _WorksException()
        },
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
        () async {
          final response = ConversationResponse(id: 'response1');
          final branch = ConversationBranch(
            id: 'branch1',
            responseIds: [response.id],
          );
          final conversation = Conversation(
            id: 'conversation1',
            name: 'First Conversation',
            branches: [branch],
            initialBranchId: branch.id,
            responses: [response],
          );
          final category = ConversationCategory(
            id: 'category1',
            name: 'First Conversation Category',
            conversations: [conversation],
          );
          world.conversationCategories.add(category);
          final startConversation = StartConversation(
            conversationId: conversation.id,
            fadeTime: 1234,
          );
          while (game.currentLevel != null) {
            game.popLevel();
          }
          expect(game.currentLevel, isNull);
          game.pushLevel(worldContext.getMainMenu());
          world.mainMenuOptions.fadeTime = null;
          expect(world.mainMenuOptions.fadeTime, isNull);
          worldContext.handleStartConversation(startConversation);
          expect(identical(worldContext.game, game), isTrue);
          final level = game.currentLevel as ConversationLevel;
          expect(level.branch, isNull);
          expect(level.conversation, conversation);
          expect(level.fadeTime, startConversation.fadeTime);
          expect(level.reverb, isNull);
          await game.tick(startConversation.pushInitialBranchAfter - 1);
          expect(level.branch, isNull);
          await game.tick(1);
          expect(level.branch, branch);
        },
      );
      test(
        '.handleSetQuestStage',
        () {
          final stage = QuestStage(id: 'stage1');
          final quest = Quest(
            id: 'quest1',
            name: 'Quest 1',
            stages: [stage, QuestStage(id: 'stage2')],
          );
          world.quests.add(quest);
          final prefs = worldContext.playerPreferences..questStages.clear();
          worldContext.handleSetQuestStage(
            SetQuestStage(questId: quest.id, stageId: stage.id),
          );
          expect(prefs.questStages[quest.id], stage.id);
          worldContext.handleSetQuestStage(
            SetQuestStage(questId: quest.id, stageId: null),
          );
          expect(prefs.questStages[quest.id], isNull);
        },
      );
    },
  );
  group(
    'Conditionals',
    () {
      final world = World(
        globalOptions: WorldOptions(appName: appName, orgName: orgName),
      );
      final worldContext = WorldContext(
        game: game,
        world: world,
      );
      test(
        '.handleQuestCondition',
        () {
          final stage = QuestStage(id: 'stage1');
          final quest = Quest(
            id: 'quest1',
            name: 'Quest 1',
            stages: [stage, QuestStage(id: 'stage2')],
          );
          world.quests.add(quest);
          final prefs = worldContext.playerPreferences..questStages.clear();
          expect(
            worldContext.handleQuestCondition(
              QuestCondition(questId: quest.id, stageId: null),
            ),
            isTrue,
          );
          expect(prefs.questStages[quest.id], isNull);
          expect(
            worldContext.handleQuestCondition(
              QuestCondition(questId: quest.id, stageId: stage.id),
            ),
            isFalse,
          );
          expect(prefs.questStages[quest.id], isNull);
          prefs.questStages[quest.id] = stage.id;
          expect(
            worldContext.handleQuestCondition(
              QuestCondition(questId: quest.id, stageId: null),
            ),
            isFalse,
          );
          expect(
            worldContext.handleQuestCondition(
              QuestCondition(questId: quest.id, stageId: quest.stages.last.id),
            ),
            isFalse,
          );
          expect(
            worldContext.handleQuestCondition(
              QuestCondition(questId: quest.id, stageId: stage.id),
            ),
            isTrue,
          );
        },
      );
    },
  );
}
