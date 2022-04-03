// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldStat _$WorldStatFromJson(Map<String, dynamic> json) => WorldStat(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Untitled Stat',
      description: json['description'] as String? ?? 'A nondescript statistic',
      defaultValue: json['defaultValue'] as int? ?? 20,
    );

Map<String, dynamic> _$WorldStatToJson(WorldStat instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'defaultValue': instance.defaultValue,
    };
