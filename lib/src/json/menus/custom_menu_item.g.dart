// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomMenuItem _$CustomMenuItemFromJson(Map<String, dynamic> json) =>
    CustomMenuItem(
      label: json['label'] as String?,
      sound: json['sound'] == null
          ? null
          : Sound.fromJson(json['sound'] as Map<String, dynamic>),
      activateCommand: json['activateCommand'] == null
          ? null
          : CallCommand.fromJson(
              json['activateCommand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomMenuItemToJson(CustomMenuItem instance) =>
    <String, dynamic>{
      'label': instance.label,
      'sound': instance.sound,
      'activateCommand': instance.activateCommand,
    };
