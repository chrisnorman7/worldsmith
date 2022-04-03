// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartConversation _$StartConversationFromJson(Map<String, dynamic> json) =>
    StartConversation(
      conversationId: json['conversationId'] as String,
      pushInitialBranchAfter: json['pushInitialBranchAfter'] as int? ?? 5,
      fadeTime: json['fadeTime'] as int? ?? 500,
    );

Map<String, dynamic> _$StartConversationToJson(StartConversation instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'pushInitialBranchAfter': instance.pushInitialBranchAfter,
      'fadeTime': instance.fadeTime,
    };
