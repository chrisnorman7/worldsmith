/// Provides the [StartConversation] class.
import 'package:json_annotation/json_annotation.dart';

part 'start_conversation.g.dart';

/// A class that stores settings for starting conversations.
@JsonSerializable()
class StartConversation {
  /// Create an instance.
  StartConversation({
    required this.conversationId,
    this.fadeTime = 500,
  });

  /// Create an instance from a JSON object.
  factory StartConversation.fromJson(Map<String, dynamic> json) =>
      _$StartConversationFromJson(json);

  /// The ID of the conversation to start.
  String conversationId;

  /// The fade time to use.
  int? fadeTime;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$StartConversationToJson(this);
}
