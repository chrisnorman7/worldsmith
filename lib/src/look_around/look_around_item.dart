/// Provides the [LookAroundObject] class.
import 'dart:math';

import '../json/sounds/sound.dart';

/// A class for representing objects in a zone, relative to the player.
class LookAroundObject {
  /// Create an instance.
  const LookAroundObject({
    required this.name,
    required this.coordinates,
    this.icon,
  });

  /// The name of the object.
  final String name;

  /// The sound icon for the object.
  final Sound? icon;

  /// The coordinates of the object.
  final Point<double> coordinates;
}
