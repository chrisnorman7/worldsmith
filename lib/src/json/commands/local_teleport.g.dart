// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_teleport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalTeleport _$LocalTeleportFromJson(Map<String, dynamic> json) =>
    LocalTeleport(
      minCoordinates:
          Coordinates.fromJson(json['minCoordinates'] as Map<String, dynamic>),
      maxCoordinates: json['maxCoordinates'] == null
          ? null
          : Coordinates.fromJson(
              json['maxCoordinates'] as Map<String, dynamic>),
      heading: json['heading'] as int? ?? 0,
    );

Map<String, dynamic> _$LocalTeleportToJson(LocalTeleport instance) =>
    <String, dynamic>{
      'minCoordinates': instance.minCoordinates,
      'maxCoordinates': instance.maxCoordinates,
      'heading': instance.heading,
    };
