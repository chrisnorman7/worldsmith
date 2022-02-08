/// Provides loading functions.
import 'dart:convert';
import 'dart:io';

import '../json/world.dart';

/// The type for all JSON.
typedef JsonType = Map<String, dynamic>;

/// Return a world loaded from the given [filename].
World loadJson(String filename) {
  final file = File(filename);
  final data = file.readAsStringSync();
  final json = jsonDecode(data) as JsonType;
  return World.fromJson(json);
}
