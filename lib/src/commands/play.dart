import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_sdl/dart_sdl.dart';
import 'package:path/path.dart' as path;
import 'package:ziggurat/ziggurat.dart' show Game;

import '../../command_triggers.dart';
import '../../world_context.dart';
import '../json/world.dart';

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
    final world = World.fromFilename(filename);
    final game = Game(world.title, triggerMap: defaultTriggerMap);
    final sdl = Sdl();
    final worldContext = WorldContext(
      sdl: sdl,
      game: game,
      world: world,
    );
    return worldContext.run();
  }
}
