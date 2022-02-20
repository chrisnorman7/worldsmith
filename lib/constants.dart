import 'dart:convert';

import 'package:ziggurat/ziggurat.dart';

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
