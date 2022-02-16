// ignore_for_file: avoid_print
import 'package:args/command_runner.dart';
import 'package:worldsmith/commands.dart';

Future<void> main(List<String> args) async {
  final command = CommandRunner<void>(
    'worldsmith',
    'Work with worldsmith directories.',
  )
    ..addCommand(RunCommand())
    ..addCommand(BuildCommand());
  try {
    await command.run(args);
  } on UsageException catch (e) {
    print(e);
  }
}