import 'package:json_annotation/json_annotation.dart';

import '../messages/custom_message.dart';
import 'coordinates.dart';
import 'zone.dart';

part 'location_marker.g.dart';

/// A location marker in a [Zone].
@JsonSerializable()
class LocationMarker {
  /// Create an instance.
  LocationMarker({
    required this.id,
    required this.message,
    required this.coordinates,
  });

  /// Create an instance from a JSON object.
  factory LocationMarker.fromJson(final Map<String, dynamic> json) =>
      _$LocationMarkerFromJson(json);

  /// The ID of this marker.
  final String id;

  /// The message that describes this marker.
  final CustomMessage message;

  /// The coordinates this marker describes.
  final Coordinates coordinates;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$LocationMarkerToJson(this);
}
