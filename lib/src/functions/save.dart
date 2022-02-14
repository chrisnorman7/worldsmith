/// Provides the [saveEncrypted] function.
import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';

import '../../constants.dart';
import '../json/world.dart';

/// Returns the given [world] as a JSON string.
String worldJsonString(World world) => jsonEncode(world.toJson());

/// Save the given [world] with a random encryption key.
///
/// The encryption key will be returned.
String saveEncrypted(World world, {String filename = encryptedWorldFilename}) {
  final file = File(filename);
  final encryptionKey = SecureRandom(32).base64;
  final key = Key.fromBase64(encryptionKey);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  final data = encrypter.encrypt(worldJsonString(world), iv: iv).bytes;
  file.writeAsBytesSync(data);
  return encryptionKey;
}
