# worldsmith

## Description

This package has two main functions:

* Provide an API which can be used to create JSON-serializable RPG's in pure dart.
* Provide a command line utility (`worldsmith`) to run and compile those games once they have been converted to JSON.

## Features

* Create games by just creating objects.
* Dump the worlds you create to json.
* Play and compile JSON games with the `worldsmith` utility.

## Getting started

Create a world:

```dart
import 'package:worldsmith/worldsmith.dart';

Future<void> main() {
  final world = World(title: 'Example World');
}
```

Now create a game that can serve as the interface between worldsmith and ziggurat.

```dart
import 'package:worldsmith/command_triggers.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/ziggurat.dart';

Future<void> main() {
  final world = World(title: 'Example World');
  final game = Game(world.title, triggerMap: defaultTriggerMap);
}
```

Now create a `WorldContext` instance.

```dart
import 'package:worldsmith/command_triggers.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/ziggurat.dart';

Future<void> main() {
  final world = World(title: 'Example World');
  final game = Game(world.title, triggerMap: defaultTriggerMap);
  final worldContext = WorldContext(game: game, world: world);
}
```

Now run the world.

```dart
import 'package:worldsmith/command_triggers.dart';
import 'package:worldsmith/functions.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/ziggurat.dart';

Future<void> main() {
  final world = World(title: 'Example World');
  final game = Game(world.title, triggerMap: defaultTriggerMap);
  final worldContext = WorldContext(game: game, world: world);
  return runWorld(worldContext);
}
```

## Usage

This package is intended to be used from within an editor which is still under development. Users can still use this package to create games in pure code.

## Additional information

This package is still in extremely early days. If you have any problems, please [submit an issue](https://github.com/chrisnorman7/worldsmith).

## Command Line Utility

The main entry point for this package is the `worldsmith` command:

```shell
# worldsmith
Work with worldsmith directories.

Usage: worldsmith <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  build   Build worldsmith projects.
  play    Run a worldsmith file in the current directory.

Run "worldsmith help <command>" for more information about a command.
```

### Play Game

Using the `play` subcommand, you can play a worldsmith project in the current directory as if it had been compiled. You will see any errors in the console.

To do this, simply type `worldsmith play` while in the directory where you project files reside.

Unfortunately, since the package does not use Flutter, there is no hot reload.

### Build Game

You can use the `build` subcommand to generate Dart code - and an EXE for your game.

To do this, simply type `worldsmith build` from within the directory where your project files reside. A folder named `game` will be created, and your assets, as well as an encrypted version of your world's JSON file will be placed there.

*Note*: Your assets are *copied*, not *moved*, so there is obviously a space penalty.

If you are running Windows (the primary OS where this package is tested), the `editbin.exe` utility is used to stop your game.exe file from loading an ugly DOS box. Thanks to the poster [here](https://stackoverflow.com/questions/2435816/how-do-i-poke-the-flag-in-a-win32-pe-that-controls-console-window-display/14806704) for the tip.

#### Example Output

Here is the code that `worldsmith build` generated for my test world.

```dart
/// Hilly Hill.
import 'package:worldsmith/command_triggers.dart';
import 'package:worldsmith/functions.dart';
import 'package:worldsmith/world_context.dart';
import 'package:ziggurat/ziggurat.dart';

const encryptionKey = '1auHFQ6Og3zXScz7EAGT1s9/9yJiAVlyJwFVfrNCvZk=';

Future<void> main() async {
  final world = loadEncrypted(encryptionKey);
  final game = Game(world.title, triggerMap: defaultTriggerMap);
  final worldContext = WorldContext(game: game, world: world);
  await runWorld(worldContext);
}
```

As you can see, there is not much: A few imports, an encryption key constant, and a `main` function which creates a [World](https://pub.dev/documentation/worldsmith/latest/worldsmith/World-class.html) instance using the [loadEncrypted](https://pub.dev/documentation/worldsmith/latest/functions/loadEncrypted.html) function.

#### Regenerating Code

If you customise the code that `worldsmith build` generates (see [Extending]), the build system is intelligent enough to not overwrite your changes. What it does instead is run through each line of the `game/bin/game.dart` file, and replaces the old encryption key with the new one.

If you find instances where this breaks, please open an [issue](https://github.com/chrisnorman7/worldsmith_utils/issues/new).

## Extending

If you read the [worldsmith documentation](https://pub.dev/documentation/worldsmith/latest/), you will discover that the [WorldContext](https://pub.dev/documentation/worldsmith/latest/world_context/WorldContext-class.html) instance (see [Example Output]) has a lot of callbacks you can provide to customise how your game works.

If you want finer control, you could always pass in a custom [Game](https://pub.dev/documentation/ziggurat/latest/ziggurat/Game-class.html) instance, which you can use to intercept levels being pushed, and also modify the default keymap.

## Known Issues

Currently, if you run the `game.exe` file from outside its directory, it doesn't work. This may be fixed in the future.

## Reporting Issues

If you encounter any issues, please report them on the [issue tracker](https://github.com/chrisnorman7/worldsmith_utils/issues/new).
