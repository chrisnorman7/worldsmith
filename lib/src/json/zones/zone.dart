/// Provides the [Zone] class.
import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

import '../../level/pause_menu.dart';
import '../commands/call_command.dart';
import '../sound.dart';
import '../world.dart';
import 'box.dart';
import 'coordinates.dart';
import 'location_marker.dart';
import 'terrain.dart';
import 'zone_object.dart';

part 'zone.g.dart';

/// A zone in a [World] instance.
@JsonSerializable()
class Zone {
  /// Create an instance.
  Zone({
    required this.id,
    required this.name,
    required this.boxes,
    required this.defaultTerrainId,
    this.music,
    this.musicFadeTime,
    this.musicFadeGain = 0.1,
    this.ambianceFadeTime,
    this.ambianceFadeGain = 0.1,
    final List<Sound>? ambiances,
    this.topDownMap = true,
    this.edgeCommand,
    this.turnAmount = 45,
    final List<ZoneObject>? objects,
    final List<LocationMarker>? locationMarkers,
  })  : ambiances = ambiances ?? [],
        objects = objects ?? [],
        locationMarkers = locationMarkers ?? [];

  /// Create an instance from a JSON object.
  factory Zone.fromJson(final Map<String, dynamic> json) =>
      _$ZoneFromJson(json);

  /// The ID of this zone.
  final String id;

  /// The name of this zone.
  String name;

  /// The boxes in this zone.
  final List<Box> boxes;

  /// The ID of the [Terrain] to use when no [Box] has been found.
  String defaultTerrainId;

  /// The music for this zone.
  Sound? music;

  /// The fade time for music when a [PauseMenu] is pushed.
  double? musicFadeTime;

  /// The gain for music when it has been faded.
  double musicFadeGain;

  /// The fade time for object and level ambiances.
  double? ambianceFadeTime;

  /// The gain for ambiances after they have been faded.
  double ambianceFadeGain;

  /// The ambiances for this zone.
  final List<Sound> ambiances;

  /// Whether or not a top-down map of this zone can be viewed.
  bool topDownMap;

  /// The ID of the command to use when colliding with the edge of this zone.
  CallCommand? edgeCommand;

  /// The maximum turning amount in this zone.
  int turnAmount;

  /// The objects in this zone.
  final List<ZoneObject> objects;

  /// The location markers in this zone.
  final List<LocationMarker> locationMarkers;

  /// Get the location marker with the given [id].
  LocationMarker getLocationMarker(final String id) =>
      locationMarkers.firstWhere(
        (final element) => element.id == id,
      );

  /// Get a box by its [id].
  Box getBox(final String id) =>
      boxes.firstWhere((final element) => element.id == id);

  /// Get an object by its [id].
  ZoneObject getZoneObject(final String id) => objects.firstWhere(
        (final element) => element.id == id,
      );

  /// Get the absolute coordinates for the given [Coordinates].
  Point<int> getAbsoluteCoordinates(final Coordinates coordinates) {
    final clamp = coordinates.clamp;
    if (clamp == null) {
      return Point(coordinates.x, coordinates.y);
    }
    final box = getBox(clamp.boxId);
    final Point<int> point;
    switch (clamp.corner) {
      case BoxCorner.southwest:
        point = getAbsoluteCoordinates(box.start);
        break;
      case BoxCorner.southeast:
        point = getBoxSoutheastCorner(box);
        break;
      case BoxCorner.northeast:
        point = getAbsoluteCoordinates(box.end);
        break;
      case BoxCorner.northwest:
        point = getBoxNorthwestCorner(box);
        break;
    }
    return Point(point.x + coordinates.x, point.y + coordinates.y);
  }

  /// Get the point at the northwest corner of the given [box].
  Point<int> getBoxNorthwestCorner(final Box box) => Point(
        getAbsoluteCoordinates(box.start).x,
        getAbsoluteCoordinates(box.end).y,
      );

  /// Get the coordinates at the southeast corner of the given [box].
  Point<int> getBoxSoutheastCorner(final Box box) => Point(
        getAbsoluteCoordinates(box.end).x,
        getAbsoluteCoordinates(box.start).y,
      );

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ZoneToJson(this);
}
