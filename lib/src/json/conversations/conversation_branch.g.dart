// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationBranch _$ConversationBranchFromJson(Map<String, dynamic> json) =>
    ConversationBranch(
      id: json['id'] as String,
      responseIds: (json['responseIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      text: json['text'] as String?,
      sound: json['sound'] == null
          ? null
          : Sound.fromJson(json['sound'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConversationBranchToJson(ConversationBranch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'sound': instance.sound,
      'responseIds': instance.responseIds,
    };
