// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_marker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationMarker _$LocationMarkerFromJson(Map<String, dynamic> json) =>
    LocationMarker(
      id: json['id'] as String,
      coordinates:
          Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      name: json['name'] as String? ?? 'Untitled Marker',
      sound: json['sound'] == null
          ? null
          : Sound.fromJson(json['sound'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationMarkerToJson(LocationMarker instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sound': instance.sound,
      'coordinates': instance.coordinates,
    };
