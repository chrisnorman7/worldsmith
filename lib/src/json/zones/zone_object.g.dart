// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoneObject _$ZoneObjectFromJson(Map<String, dynamic> json) => ZoneObject(
      id: json['id'] as String,
      name: json['name'] as String,
      initialCoordinates: json['initialCoordinates'] == null
          ? null
          : Coordinates.fromJson(
              json['initialCoordinates'] as Map<String, dynamic>),
      ambiance: json['ambiance'] == null
          ? null
          : Sound.fromJson(json['ambiance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ZoneObjectToJson(ZoneObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'initialCoordinates': instance.initialCoordinates,
      'ambiance': instance.ambiance,
    };
