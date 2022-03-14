import 'dart:convert';

import 'package:ziggurat/ziggurat.dart';

import 'src/json/conditionals/conditional.dart';
import 'world_context.dart';

/// The directory where assets will be stored.
const assetsDirectory = 'assets';

/// The default directions.
const defaultDirections = {
  'North': CardinalDirections.north,
  'Northeast': CardinalDirections.northeast,
  'East': CardinalDirections.east,
  'Southeast': CardinalDirections.southeast,
  'South': CardinalDirections.south,
  'Southwest': CardinalDirections.southwest,
  'West': CardinalDirections.west,
  'Northwest': CardinalDirections.northwest,
};

/// The type for event callbacks.
typedef EventCallback<T> = void Function(T event);

/// The filename for encrypted world files.
const encryptedWorldFilename = 'world.data';

/// A JSON encoder that indents.
const indentedJsonEncoder = JsonEncoder.withIndent('  ');

/// The type for all JSON.
typedef JsonType = Map<String, dynamic>;

/// The possible directions to walk in.
enum WalkingDirection {
  /// Forwards.
  forwards,

  /// Backwards.
  backwards,

  /// Sidestep left.
  left,

  /// Sidestep right.
  right,
}

/// The filename where preferences are stored.
const preferencesFilename = 'preferences.json';

/// The filename where the trigger map is stored.
const triggerMapFilename = 'triggers.json';

/// The type of an error handler function.
typedef ErrorHandler = void Function(Object e, StackTrace? s);

/// The type of a custom commands map.
typedef CustomCommandsMap = Map<String, EventCallback<WorldContext>>;

/// The type of a conditional functions map.
typedef ConditionalFunctionsMap
    = Map<String, bool Function(WorldContext worldContext)>;

/// The type of a list of conditionals.
typedef ConditionalList = List<Conditional>;
