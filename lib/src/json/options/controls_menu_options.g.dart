// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controls_menu_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ControlsMenuOptions _$ControlsMenuOptionsFromJson(Map<String, dynamic> json) =>
    ControlsMenuOptions(
      title: json['title'] as String? ?? 'Game Controls',
      music: json['music'] == null
          ? null
          : Sound.fromJson(json['music'] as Map<String, dynamic>),
      ambianceFadeTime: (json['ambianceFadeTime'] as num?)?.toDouble(),
      itemSound: json['itemSound'] == null
          ? null
          : Sound.fromJson(json['itemSound'] as Map<String, dynamic>),
      subMenuTitle: json['subMenuTitle'] as String? ?? 'Controls',
      gameControllerButtonPrefix:
          json['gameControllerButtonPrefix'] as String? ??
              'Game Controller Button: ',
      emptyGameControllerButtonMessage:
          json['emptyGameControllerButtonMessage'] as String? ?? '<Not Set>',
      keyboardControlPrefix:
          json['keyboardControlPrefix'] as String? ?? 'Keyboard Keys: ',
      emptyKeyboardControlMessage:
          json['emptyKeyboardControlMessage'] as String? ?? '<Not Set>',
    );

Map<String, dynamic> _$ControlsMenuOptionsToJson(
        ControlsMenuOptions instance) =>
    <String, dynamic>{
      'title': instance.title,
      'music': instance.music,
      'ambianceFadeTime': instance.ambianceFadeTime,
      'itemSound': instance.itemSound,
      'subMenuTitle': instance.subMenuTitle,
      'gameControllerButtonPrefix': instance.gameControllerButtonPrefix,
      'emptyGameControllerButtonMessage':
          instance.emptyGameControllerButtonMessage,
      'keyboardControlPrefix': instance.keyboardControlPrefix,
      'emptyKeyboardControlMessage': instance.emptyKeyboardControlMessage,
    };
