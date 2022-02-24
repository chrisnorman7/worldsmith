// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Box _$BoxFromJson(Map<String, dynamic> json) => Box(
      id: json['id'] as String,
      name: json['name'] as String,
      start: Coordinates.fromJson(json['start'] as Map<String, dynamic>),
      end: Coordinates.fromJson(json['end'] as Map<String, dynamic>),
      terrainId: json['terrainId'] as String,
      enclosed: json['enclosed'] as bool? ?? false,
      reverbId: json['reverbId'] as String?,
      enterCommand: json['enterCommand'] == null
          ? null
          : CallCommand.fromJson(json['enterCommand'] as Map<String, dynamic>),
      leaveCommand: json['leaveCommand'] == null
          ? null
          : CallCommand.fromJson(json['leaveCommand'] as Map<String, dynamic>),
      walkCommand: json['walkCommand'] == null
          ? null
          : CallCommand.fromJson(json['walkCommand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BoxToJson(Box instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'start': instance.start,
      'end': instance.end,
      'terrainId': instance.terrainId,
      'enclosed': instance.enclosed,
      'reverbId': instance.reverbId,
      'enterCommand': instance.enterCommand,
      'leaveCommand': instance.leaveCommand,
      'walkCommand': instance.walkCommand,
    };
