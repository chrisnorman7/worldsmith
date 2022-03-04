import 'package:json_annotation/json_annotation.dart';

import 'conversation_branch.dart';
import 'conversation_response.dart';

part 'conversation.g.dart';

/// A class representing a conversation between the player and a game entity.
@JsonSerializable()
class Conversation {
  /// Create an instance.
  Conversation({
    required this.id,
    required this.name,
    required this.branches,
    required this.initialBranchId,
    required this.responses,
  });

  /// Create an instance from a JSON object.
  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  /// The ID of this conversation.
  final String id;

  /// The name of this conversation.
  String name;

  /// The branches of this conversation.
  final List<ConversationBranch> branches;

  /// Get the branch with the given [id].
  ConversationBranch getBranch(String id) => branches.firstWhere(
        (element) => element.id == id,
      );

  /// The ID of the first branch to be reached.
  String initialBranchId;

  /// The responses that belong to this conversation.
  final List<ConversationResponse> responses;

  /// Get the response with the given [id].
  ConversationResponse getResponse(String id) => responses.firstWhere(
        (element) => element.id == id,
      );

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
