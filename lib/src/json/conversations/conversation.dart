import 'package:json_annotation/json_annotation.dart';

import '../sounds/sound.dart';
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
    this.music,
    this.reverbId,
  });

  /// Create an instance from a JSON object.
  factory Conversation.fromJson(final Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  /// The ID of this conversation.
  final String id;

  /// The name of this conversation.
  String name;

  /// The branches of this conversation.
  final List<ConversationBranch> branches;

  /// Get the branch with the given [id].
  ConversationBranch getBranch(final String id) => branches.firstWhere(
        (final element) => element.id == id,
      );

  /// The ID of the first branch to be reached.
  String initialBranchId;

  /// The initial branch.
  ConversationBranch get initialBranch => getBranch(initialBranchId);

  /// The responses that belong to this conversation.
  final List<ConversationResponse> responses;

  /// Get the response with the given [id].
  ConversationResponse getResponse(final String id) => responses.firstWhere(
        (final element) => element.id == id,
      );

  /// The music for this conversation.
  Sound? music;

  /// The ID of the reverb to pass all sounds through.
  String? reverbId;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
