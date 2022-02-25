// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_marker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationMarker _$LocationMarkerFromJson(Map<String, dynamic> json) =>
    LocationMarker(
      id: json['id'] as String,
      message: CustomMessage.fromJson(json['message'] as Map<String, dynamic>),
      coordinates:
          Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationMarkerToJson(LocationMarker instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'coordinates': instance.coordinates,
    };
