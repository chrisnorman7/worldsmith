// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
      id: json['id'] as String,
      name: json['name'] as String,
      branches: (json['branches'] as List<dynamic>)
          .map((e) => ConversationBranch.fromJson(e as Map<String, dynamic>))
          .toList(),
      initialBranchId: json['initialBranchId'] as String,
      responses: (json['responses'] as List<dynamic>)
          .map((e) => ConversationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      music: json['music'] == null
          ? null
          : Sound.fromJson(json['music'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'branches': instance.branches,
      'initialBranchId': instance.initialBranchId,
      'responses': instance.responses,
      'music': instance.music,
    };
