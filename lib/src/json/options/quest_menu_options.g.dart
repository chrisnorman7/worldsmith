// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_menu_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestMenuOptions _$QuestMenuOptionsFromJson(Map<String, dynamic> json) =>
    QuestMenuOptions(
      title: json['title'] as String? ?? 'Quests',
      noQuestsMessage: json['noQuestsMessage'] as String? ??
          "You haven't started any quests",
    );

Map<String, dynamic> _$QuestMenuOptionsToJson(QuestMenuOptions instance) =>
    <String, dynamic>{
      'title': instance.title,
      'noQuestsMessage': instance.noQuestsMessage,
    };
