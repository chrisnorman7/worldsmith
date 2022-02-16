import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;
import 'package:ziggurat/ziggurat.dart' show Game;

import '../../world_context.dart';
import '../functions/load.dart';
import '../functions/run.dart';

/// The `run` command.
class RunCommand extends Command<void> {
  /// Create an instance.
  RunCommand() {
    argParser.addOption(
      'filename',
      abbr: 'f',
      help: 'The JSON file to load',
      allowed: [
        for (final file in Directory.current
            .listSync()
            .whereType<File>()
            .where((element) => element.path.endsWith('.json')))
          path.basename(file.path)
      ],
      defaultsTo: 'project.json',
    );
  }

  @override
  String get description => 'Run a worldsmith file in the current directory.';

  @override
  String get name => 'play';

  @override
  Future<void> run() async {
    final results = argResults!;
    final filename = results['filename'] as String;
    final world = loadJson(filename);
    final game = Game(world.title);
    final worldContext = WorldContext(game: game, world: world);
    return runWorld(worldContext);
  }
}
