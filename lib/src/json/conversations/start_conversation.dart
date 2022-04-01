/// Provides the [StartConversation] class.
import 'package:json_annotation/json_annotation.dart';

part 'start_conversation.g.dart';

/// A class that stores settings for starting conversations.
@JsonSerializable()
class StartConversation {
  /// Create an instance.
  StartConversation({
    required this.conversationId,
    this.pushInitialBranchAfter = 5,
    this.fadeTime = 500,
  });

  /// Create an instance from a JSON object.
  factory StartConversation.fromJson(final Map<String, dynamic> json) =>
      _$StartConversationFromJson(json);

  /// The ID of the conversation to start.
  String conversationId;

  /// How long should the game wait before pushing the first branch.
  int pushInitialBranchAfter;

  /// The fade time to use.
  int? fadeTime;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$StartConversationToJson(this);
}
