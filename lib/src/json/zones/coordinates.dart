/// Provides classes related to coordinates.
import 'package:json_annotation/json_annotation.dart';

part 'coordinates.g.dart';

/// The corners of a box.
enum BoxCorner {
  /// The bottom left corner of a box.
  southwest,

  /// The bottom right corner of a box.
  southeast,

  /// The top right corner of a box, or the end coordinates.
  northeast,

  /// The top left corner of a box.
  northwest,
}

/// A clamp for a [Coordinates] instance.
@JsonSerializable()
class CoordinateClamp {
  /// Create an instance.
  const CoordinateClamp({required this.boxId, required this.corner});

  /// Create an instance from a JSON object.
  factory CoordinateClamp.fromJson(Map<String, dynamic> json) =>
      _$CoordinateClampFromJson(json);

  /// The ID of the box to clamp to.
  final String boxId;

  /// The corner to clamp to.
  final BoxCorner corner;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$CoordinateClampToJson(this);
}

/// A pair of coordinates.
@JsonSerializable()
class Coordinates {
  /// Create an instance.
  const Coordinates(this.x, this.y, {this.clamp});

  /// Create an instance from a JSON object.
  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  /// The x coordinate.
  final int x;

  /// The y coordinate.
  final int y;

  /// The clamp for these coordinates.
  ///
  /// Exactly one box can have clamped coordinates.
  final CoordinateClamp? clamp;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
