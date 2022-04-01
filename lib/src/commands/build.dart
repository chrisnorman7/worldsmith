// ignore_for_file: avoid_print
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_sdl/dart_sdl.dart';
import 'package:path/path.dart' as path;
import 'package:ziggurat/ziggurat.dart' show Game;

import '../../constants.dart';
import '../../world_context.dart';
import '../json/world.dart';

/// The dart executable.
const dart = 'dart';

/// The default code for `bin/game.dart`..
const code = '''/// {worldTitle}.
import 'package:worldsmith/world_context.dart';

const encryptionKey = '{encryptionKey}';

Future<void> main() async {
  final worldContext = WorldContext.loadEncrypted(encryptionKey: encryptionKey);
  await worldContext.run();
}
''';

void main() {}

/// Non 0 exit code.
class ProcessError implements Exception {}

/// The `build` command.
class BuildCommand extends Command<void> {
  /// Create an instance.
  BuildCommand() {
    argParser
      ..addOption(
        'filename',
        abbr: 'f',
        help: 'The JSON file to load',
        allowed: [
          for (final file in Directory.current
              .listSync()
              .whereType<File>()
              .where((final element) => element.path.endsWith('.json')))
            path.basename(file.path)
        ],
        defaultsTo: 'project.json',
      )
      ..addOption(
        'package',
        abbr: 'p',
        defaultsTo: 'game',
        help: 'The name of the package that will be created.',
      )
      ..addOption('sdl-lib', help: 'The path to the SDL2 dynamic library.')
      ..addOption(
        'synthizer-lib',
        help: 'The path to the synthizer dynamic library',
      )
      ..addOption(
        'libsndfile-lib',
        help: 'The path to the libsndfile dynamic library.',
      );
  }

  @override
  String get description => 'Build worldsmith projects.';

  @override
  String get name => 'build';

  /// Run the given [executable] with the given [arguments].
  ///
  /// If there is a non-0 exit code, [ProcessError] will be thrown.
  void runProcess(final String executable, final List<String> arguments) {
    final result = Process.runSync(executable, arguments);
    print(result.stdout);
    if (result.exitCode != 0) {
      print(result.stderr);
      throw ProcessError();
    }
  }

  @override
  void run() {
    final results = argResults!;
    final packageName = results['package'] as String;
    final sdlLib = results['sdl-lib'] as String?;
    final synthizerLib = results['synthizer-lib'] as String?;
    final libsndfileLib = results['libsndfile-lib'] as String?;
    final game = Game('World Builder');
    final world = World.fromFilename(results['filename'] as String);
    print('World: ${world.title}');
    final sdl = Sdl();
    final worldContext = WorldContext(
      sdl: sdl,
      game: game,
      world: world,
    );
    final directory = Directory(packageName);
    if (directory.existsSync() == false) {
      print('Creating directory $packageName.');
      directory.createSync();
    }
    final dartFilename = path.join(packageName, 'bin', '$packageName.dart');
    final dartFile = File(dartFilename);
    final encryptionKeyFile = File(path.join(packageName, 'world.key'));
    String? oldEncryptionKey;
    if (encryptionKeyFile.existsSync()) {
      oldEncryptionKey = encryptionKeyFile.readAsStringSync();
    }
    final worldFilename = path.join(packageName, encryptedWorldFilename);
    print('Writing world to $worldFilename.');
    final encryptionKey = worldContext.saveEncrypted(
      filename: worldFilename,
    );
    encryptionKeyFile.writeAsStringSync(encryptionKey);
    print(
      'Encryption key $encryptionKey written to ${encryptionKeyFile.path}.',
    );
    String source;
    if (dartFile.existsSync() == false || oldEncryptionKey == null) {
      print('Generating dart code.');
      runProcess(
        dart,
        [
          'create',
          '--force',
          '--no-pub',
          '-t',
          'console-simple',
          packageName,
        ],
      );
      for (final name in [
        'ziggurat',
        'ziggurat_sounds',
        'dart_sdl',
        'dart_synthizer',
        'worldsmith'
      ]) {
        runProcess(dart, ['pub', '-C', packageName, 'add', name]);
      }
      source = code;
      final data = {'encryptionKey': encryptionKey, 'worldTitle': world.title};
      for (final entry in data.entries) {
        source = source.replaceAll('{${entry.key}}', entry.value);
      }
    } else {
      runProcess(
        dart,
        ['pub', '-C', packageName, 'upgrade', '--major-versions'],
      );
      print('Modifying $dartFilename.');
      final stringBuffer = StringBuffer();
      final lines = dartFile.readAsLinesSync();
      for (final line in lines) {
        stringBuffer.writeln(line.replaceAll(oldEncryptionKey, encryptionKey));
      }
      source = stringBuffer.toString();
    }
    dartFile.writeAsStringSync(source);
    print('Copying assets...');
    var i = 0;
    for (final entity in Directory('assets').listSync(recursive: true)) {
      final origin = entity.path;
      final destination = path.join(packageName, origin);
      if (entity is File) {
        i++;
        print('$origin -> $destination');
        final file = File(destination);
        final directory = file.parent;
        if (directory.existsSync() == false) {
          print('Creating directory ${directory.path}.');
          directory.createSync(recursive: true);
        }
        file.writeAsBytesSync(File(origin).readAsBytesSync());
      }
    }
    print('Assets: $i.');
    final exeName = path.join(
      packageName,
      '$packageName${Platform.isWindows ? ".exe" : ""}',
    );
    runProcess(dart, [
      'compile',
      'exe',
      '-o',
      exeName,
      dartFilename,
    ]);
    String? sdlDestination;
    if (sdlLib != null) {
      sdlDestination = path.join(packageName, path.basename(sdlLib));
      print('$sdlLib -> $sdlDestination.');
      File(sdlDestination).writeAsBytesSync(File(sdlLib).readAsBytesSync());
    }
    String? synthizerDestination;
    if (synthizerLib != null) {
      synthizerDestination = path.join(
        packageName,
        path.basename(synthizerLib),
      );
      print('$synthizerLib -> $synthizerDestination.');
      File(
        synthizerDestination,
      ).writeAsBytesSync(File(synthizerLib).readAsBytesSync());
    }
    String? libsndfileDestination;
    if (libsndfileLib != null) {
      libsndfileDestination = path.join(
        packageName,
        path.basename(libsndfileLib),
      );
      print('$libsndfileLib -> $libsndfileDestination.');
      File(
        libsndfileDestination,
      ).writeAsBytesSync(File(libsndfileLib).readAsBytesSync());
    }
    if (Platform.isWindows) {
      try {
        runProcess('editbin', [
          '/subsystem:windows',
          exeName,
        ]);
      } on ProcessException {
        print(
          'There was an error running the `editbin` command. Ensure you have '
          'it in your path.',
        );
        print(
          'If you have Visual Studio installed, try locating and running the '
          '`vcvars64.bat` file.',
        );
      }
    }
    print('Build complete.');
    if (sdlDestination == null) {
      print(
        'Place the sdl dynamic library file inside the `$packageName` '
        'directory.',
      );
    }
    if (synthizerDestination == null) {
      print(
        'Place the synthizer dynamic library file inside the `$packageName` '
        'directory.',
      );
    }
    if (libsndfileDestination == null) {
      print(
        'If desired, place the libsndfile dynamic library file inside the '
        '`$packageName` directory.',
      );
    }
    print('When making a release, the following files must be included:');
    for (final filename in [
      path.join(packageName, 'assets'),
      exeName,
      worldFilename,
      if (synthizerDestination != null) synthizerDestination,
      if (sdlDestination != null) sdlDestination,
      if (libsndfileDestination != null) libsndfileDestination
    ]) {
      print('  $filename');
    }
  }
}
