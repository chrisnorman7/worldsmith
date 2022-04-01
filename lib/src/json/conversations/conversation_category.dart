import 'package:json_annotation/json_annotation.dart';

import 'conversation.dart';

part 'conversation_category.g.dart';

/// A category for holding [conversations].
@JsonSerializable()
class ConversationCategory {
  /// Create an instance.
  ConversationCategory({
    required this.id,
    required this.name,
    required this.conversations,
  });

  /// Create an instance from a JSON object.
  factory ConversationCategory.fromJson(final Map<String, dynamic> json) =>
      _$ConversationCategoryFromJson(json);

  /// The ID of this category.
  final String id;

  /// The name of this category.
  String name;

  /// The conversations which are bound to this category.
  final List<Conversation> conversations;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ConversationCategoryToJson(this);
}
