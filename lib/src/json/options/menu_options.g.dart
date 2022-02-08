// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuOptions _$MenuOptionsFromJson(Map<String, dynamic> json) => MenuOptions(
      title: json['title'] as String,
      musicId: json['musicId'] as String?,
      fadeTime: (json['fadeTime'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MenuOptionsToJson(MenuOptions instance) =>
    <String, dynamic>{
      'title': instance.title,
      'musicId': instance.musicId,
      'fadeTime': instance.fadeTime,
    };
