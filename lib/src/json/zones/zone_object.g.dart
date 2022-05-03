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
      collideCommand: json['collideCommand'] == null
          ? null
          : CallCommand.fromJson(
              json['collideCommand'] as Map<String, dynamic>),
      icon: json['icon'] == null
          ? null
          : Sound.fromJson(json['icon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ZoneObjectToJson(ZoneObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'initialCoordinates': instance.initialCoordinates,
      'ambiance': instance.ambiance,
      'collideCommand': instance.collideCommand,
      'icon': instance.icon,
    };
