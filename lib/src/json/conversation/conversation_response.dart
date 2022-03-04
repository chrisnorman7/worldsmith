import 'package:json_annotation/json_annotation.dart';

import '../commands/call_command.dart';
import '../messages/custom_message.dart';
import 'conversation.dart';
import 'conversation_branch.dart';
import 'conversation_next_branch.dart';

part 'conversation_response.g.dart';

/// A response to a [ConversationBranch].
///
/// Instances of this class represent player responses in a
/// [Conversation].
@JsonSerializable()
class ConversationResponse {
  /// Create an instance.
  ConversationResponse({
    required this.id,
    required this.message,
    this.nextBranch,
    this.command,
  });

  /// Create an instance from a JSON object.
  factory ConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseFromJson(json);

  /// The ID of this response.
  final String id;

  /// The message that will represent this response in the responses list.
  final CustomMessage message;

  /// The ID of a further [ConversationBranch] to show.
  ///
  /// If this value is `null`, then the conversation ends, and the player is
  /// returned to their level.
  ConversationNextBranch? nextBranch;

  /// A command to call when this response has been given.
  CallCommand? command;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ConversationResponseToJson(this);
}
