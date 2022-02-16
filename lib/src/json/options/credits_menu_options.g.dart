// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credits_menu_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditsMenuOptions _$CreditsMenuOptionsFromJson(Map<String, dynamic> json) =>
    CreditsMenuOptions(
      title: json['title'] as String? ?? 'Acknowledgements',
      music: json['music'] == null
          ? null
          : Sound.fromJson(json['music'] as Map<String, dynamic>),
      fadeTime: (json['fadeTime'] as num?)?.toDouble() ?? 3.0,
      zoneOverviewLabel:
          json['zoneOverviewLabel'] as String? ?? 'Zone Overview',
    );

Map<String, dynamic> _$CreditsMenuOptionsToJson(CreditsMenuOptions instance) =>
    <String, dynamic>{
      'title': instance.title,
      'music': instance.music,
      'fadeTime': instance.fadeTime,
      'zoneOverviewLabel': instance.zoneOverviewLabel,
    };
