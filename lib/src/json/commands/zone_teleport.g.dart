// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_teleport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoneTeleport _$ZoneTeleportFromJson(Map<String, dynamic> json) => ZoneTeleport(
      zoneId: json['zoneId'] as String,
      minCoordinates:
          Coordinates.fromJson(json['minCoordinates'] as Map<String, dynamic>),
      maxCoordinates: json['maxCoordinates'] == null
          ? null
          : Coordinates.fromJson(
              json['maxCoordinates'] as Map<String, dynamic>),
      fadeTime: (json['fadeTime'] as num?)?.toDouble(),
      heading: json['heading'] as int? ?? 0,
    );

Map<String, dynamic> _$ZoneTeleportToJson(ZoneTeleport instance) =>
    <String, dynamic>{
      'minCoordinates': instance.minCoordinates,
      'maxCoordinates': instance.maxCoordinates,
      'heading': instance.heading,
      'zoneId': instance.zoneId,
      'fadeTime': instance.fadeTime,
    };
