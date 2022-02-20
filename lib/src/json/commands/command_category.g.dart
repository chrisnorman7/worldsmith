// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommandCategory _$CommandCategoryFromJson(Map<String, dynamic> json) =>
    CommandCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      commands: (json['commands'] as List<dynamic>)
          .map((e) => WorldCommand.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommandCategoryToJson(CommandCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'commands': instance.commands,
    };
