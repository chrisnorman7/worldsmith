import 'package:ziggurat/levels.dart';
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

import 'src/json/zones/zone.dart';
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

/// The type for a function that returns a menu.
typedef MenuBuilder<T extends Menu> = T Function(WorldContext worldContext);

/// The builder for a menu which takes a zone argument.
typedef ZoneMenuBuilder<T extends Level> = T Function(
  WorldContext worldContext,
  Zone zone,
);

/// The filename for encrypted world files.
const encryptedWorldFilename = 'world.data';
