import 'package:json_annotation/json_annotation.dart';

import '../messages/custom_message.dart';
import 'conversation.dart';
import 'conversation_response.dart';

part 'conversation_branch.g.dart';

/// A class representing a branch in a [Conversation].
@JsonSerializable()
class ConversationBranch {
  /// Create an instance.
  const ConversationBranch({
    required this.id,
    required this.message,
    required this.responseIds,
  });

  /// Create an instance from a JSON object.
  factory ConversationBranch.fromJson(Map<String, dynamic> json) =>
      _$ConversationBranchFromJson(json);

  /// The ID of this branch.
  final String id;

  /// The message to show when this branch is reached.
  final CustomMessage message;

  /// A list of [ConversationResponse] IDs to show.
  final List<String> responseIds;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ConversationBranchToJson(this);
}
