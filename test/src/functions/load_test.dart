import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:worldsmith/constants.dart';
import 'package:worldsmith/src/functions/save.dart';
import 'package:worldsmith/worldsmith.dart';

final worldFile = File('world.json');
final worldFileEncrypted = File(encryptedWorldFilename);

/// Save the given [world].
void saveWorld(World world) {
  final data = jsonEncode(world.toJson());
  worldFile.writeAsStringSync(data);
}

void main() {
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
          final loadedWorld = loadString(worldFile.readAsStringSync());
          expect(loadedWorld.title, world.title);
        },
      );
      test(
        'loadEncryptedString',
        () {
          final world = World(title: 'Encrypted World');
          final encryptionKey = saveEncrypted(world);
          expect(encryptionKey, isNotEmpty);
          final loadedWorld = loadEncrypted(encryptionKey);
          expect(loadedWorld.title, world.title);
        },
      );
    },
  );
}
