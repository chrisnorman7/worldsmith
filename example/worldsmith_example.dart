import 'package:worldsmith/command_triggers.dart';
import 'package:worldsmith/functions.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/ziggurat.dart';

Future<void> main() {
  final world = World(title: 'Example World');
  final game = Game(world.title, triggerMap: defaultTriggerMap);
  return runWorld(WorldContext(game: game, world: world));
}
