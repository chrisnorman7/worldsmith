// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Zone _$ZoneFromJson(Map<String, dynamic> json) => Zone(
      id: json['id'] as String,
      name: json['name'] as String,
      boxes: (json['boxes'] as List<dynamic>)
          .map((e) => Box.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultTerrainId: json['defaultTerrainId'] as String,
      music: json['music'] == null
          ? null
          : Sound.fromJson(json['music'] as Map<String, dynamic>),
      topDownMap: json['topDownMap'] as bool? ?? true,
      edgeMessage: json['edgeMessage'] == null
          ? null
          : CustomMessage.fromJson(json['edgeMessage'] as Map<String, dynamic>),
      turnAmount: json['turnAmount'] as int? ?? 5,
    );

Map<String, dynamic> _$ZoneToJson(Zone instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'boxes': instance.boxes,
      'defaultTerrainId': instance.defaultTerrainId,
      'music': instance.music,
      'topDownMap': instance.topDownMap,
      'edgeMessage': instance.edgeMessage,
      'turnAmount': instance.turnAmount,
    };
