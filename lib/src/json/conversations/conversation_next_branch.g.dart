// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_next_branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationNextBranch _$ConversationNextBranchFromJson(
        Map<String, dynamic> json) =>
    ConversationNextBranch(
      branchId: json['branchId'] as String,
      fadeTime: (json['fadeTime'] as num?)?.toDouble() ?? 0.5,
    );

Map<String, dynamic> _$ConversationNextBranchToJson(
        ConversationNextBranch instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'fadeTime': instance.fadeTime,
    };
