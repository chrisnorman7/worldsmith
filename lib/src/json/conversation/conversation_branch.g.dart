// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationBranch _$ConversationBranchFromJson(Map<String, dynamic> json) =>
    ConversationBranch(
      id: json['id'] as String,
      message: CustomMessage.fromJson(json['message'] as Map<String, dynamic>),
      responseIds: (json['responseIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ConversationBranchToJson(ConversationBranch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'responseIds': instance.responseIds,
    };
