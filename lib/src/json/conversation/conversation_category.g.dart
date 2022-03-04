// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationCategory _$ConversationCategoryFromJson(
        Map<String, dynamic> json) =>
    ConversationCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      conversations: (json['conversations'] as List<dynamic>)
          .map((e) => Conversation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConversationCategoryToJson(
        ConversationCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'conversations': instance.conversations,
    };
