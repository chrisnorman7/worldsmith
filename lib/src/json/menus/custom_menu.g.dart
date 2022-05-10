// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomMenu _$CustomMenuFromJson(Map<String, dynamic> json) => CustomMenu(
      id: json['id'] as String,
      title: json['title'] as String,
      music: json['music'] == null
          ? null
          : Sound.fromJson(json['music'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CustomMenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      cancellable: json['cancellable'] as bool? ?? true,
      fadeTime: (json['fadeTime'] as num?)?.toDouble(),
      cancelCommand: json['cancelCommand'] == null
          ? null
          : CallCommand.fromJson(json['cancelCommand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomMenuToJson(CustomMenu instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'music': instance.music,
      'items': instance.items,
      'cancellable': instance.cancellable,
      'fadeTime': instance.fadeTime,
      'cancelCommand': instance.cancelCommand,
    };
