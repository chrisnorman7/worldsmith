/// Provides loading functions.
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ziggurat/ziggurat.dart';

import '../../constants.dart';
import '../json/world.dart';

/// The type for all JSON.
typedef JsonType = Map<String, dynamic>;

/// Return a world loaded from the given [filename].
World loadJson(String filename) {
  final file = File(filename);
  final data = file.readAsStringSync();
  return loadString(data);
}

/// Load from the provided [string].
World loadString(String string) {
  final json = jsonDecode(string) as JsonType;
  return World.fromJson(json);
}

/// Load an instance from an encrypted file.
World loadEncrypted(
  String encryptionKey, {
  String filename = encryptedWorldFilename,
}) {
  final asset = AssetReference.file(filename, encryptionKey: encryptionKey);
  final bytes = asset.load(Random());
  return loadString(String.fromCharCodes(bytes));
}
