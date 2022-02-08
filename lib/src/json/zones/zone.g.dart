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
      musicId: json['musicId'] as String?,
      topDownMap: json['topDownMap'] as bool? ?? true,
    );

Map<String, dynamic> _$ZoneToJson(Zone instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'boxes': instance.boxes,
      'defaultTerrainId': instance.defaultTerrainId,
      'musicId': instance.musicId,
      'topDownMap': instance.topDownMap,
    };
