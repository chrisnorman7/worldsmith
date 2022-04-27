import 'package:json_annotation/json_annotation.dart';

import '../sounds/sound.dart';
import 'coordinates.dart';
import 'zone.dart';

part 'location_marker.g.dart';

/// A location marker in a [Zone].
@JsonSerializable()
class LocationMarker {
  /// Create an instance.
  LocationMarker({
    required this.id,
    required this.coordinates,
    this.name = 'Untitled Marker',
    this.sound,
  });

  /// Create an instance from a JSON object.
  factory LocationMarker.fromJson(final Map<String, dynamic> json) =>
      _$LocationMarkerFromJson(json);

  /// The ID of this marker.
  final String id;

  /// The name of this marker.
  String name;

  /// The sound that represents this marker.
  Sound? sound;

  /// The coordinates this marker describes.
  final Coordinates coordinates;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$LocationMarkerToJson(this);
}
