// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldOptions _$WorldOptionsFromJson(Map<String, dynamic> json) => WorldOptions(
      framesPerSecond: json['framesPerSecond'] as int? ?? 60,
      creditsMenuTitle:
          json['creditsMenuTitle'] as String? ?? 'Acknowledgements',
      creditMusicId: json['creditMusicId'] as String?,
    );

Map<String, dynamic> _$WorldOptionsToJson(WorldOptions instance) =>
    <String, dynamic>{
      'framesPerSecond': instance.framesPerSecond,
      'creditsMenuTitle': instance.creditsMenuTitle,
      'creditMusicId': instance.creditMusicId,
    };
