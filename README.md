# worldsmith

This package lets you build RPG's by creating objects in pure Dart.

## Features

- Create games by just creating objects.
- Dump the worlds you create to json.

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
