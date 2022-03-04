// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationResponse _$ConversationResponseFromJson(
        Map<String, dynamic> json) =>
    ConversationResponse(
      id: json['id'] as String,
      message: CustomMessage.fromJson(json['message'] as Map<String, dynamic>),
      nextBranch: json['nextBranch'] == null
          ? null
          : ConversationNextBranch.fromJson(
              json['nextBranch'] as Map<String, dynamic>),
      command: json['command'] == null
          ? null
          : CallCommand.fromJson(json['command'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConversationResponseToJson(
        ConversationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'nextBranch': instance.nextBranch,
      'command': instance.command,
    };
