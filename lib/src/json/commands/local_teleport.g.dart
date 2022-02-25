// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_teleport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalTeleport _$LocalTeleportFromJson(Map<String, dynamic> json) =>
    LocalTeleport(
      locationMarkerId: json['locationMarkerId'] as String,
      heading: json['heading'] as int? ?? 0,
    );

Map<String, dynamic> _$LocalTeleportToJson(LocalTeleport instance) =>
    <String, dynamic>{
      'locationMarkerId': instance.locationMarkerId,
      'heading': instance.heading,
    };
