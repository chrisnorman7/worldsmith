// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Statistics _$StatisticsFromJson(Map<String, dynamic> json) => Statistics(
      defaultStats: Map<String, int>.from(json['defaultStats'] as Map),
      currentStats: Map<String, int>.from(json['currentStats'] as Map),
    );

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'defaultStats': instance.defaultStats,
      'currentStats': instance.currentStats,
    };
