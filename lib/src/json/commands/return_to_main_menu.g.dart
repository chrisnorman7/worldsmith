// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_to_main_menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnToMainMenu _$ReturnToMainMenuFromJson(Map<String, dynamic> json) =>
    ReturnToMainMenu(
      fadeTime: (json['fadeTime'] as num?)?.toDouble(),
      savePlayerPreferences: json['savePlayerPreferences'] as bool? ?? true,
    );

Map<String, dynamic> _$ReturnToMainMenuToJson(ReturnToMainMenu instance) =>
    <String, dynamic>{
      'fadeTime': instance.fadeTime,
      'savePlayerPreferences': instance.savePlayerPreferences,
    };
