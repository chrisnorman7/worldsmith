import 'package:json_annotation/json_annotation.dart';

import 'conversation_branch.dart';

part 'conversation_next_branch.g.dart';

/// A class which handles information about switching to a new
/// [ConversationBranch].
@JsonSerializable()
@JsonSerializable()
class ConversationNextBranch {
  /// Create an instance.
  ConversationNextBranch({
    required this.branchId,
    this.fadeTime = 0.5,
  });

  /// Create an instance from a JSON object.
  factory ConversationNextBranch.fromJson(final Map<String, dynamic> json) =>
      _$ConversationNextBranchFromJson(json);

  /// The ID of the new [ConversationBranch].
  String branchId;

  /// How long to wait until the new branch is shown.
  double fadeTime;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ConversationNextBranchToJson(this);
}
