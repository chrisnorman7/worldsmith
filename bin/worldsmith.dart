import 'package:args/command_runner.dart';
import 'package:worldsmith/commands.dart';

Future<void> main(final List<String> args) async {
  final command = CommandRunner<void>(
    'worldsmith',
    'Work with worldsmith directories.',
  )
    ..addCommand(PlayCommand())
    ..addCommand(BuildCommand());
  try {
    await command.run(args);
  } on UsageException catch (e) {
    // ignore: avoid_print
    print(e);
  }
}
