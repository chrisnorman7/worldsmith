/// Provides the [QuestStage] class.
import 'package:json_annotation/json_annotation.dart';

import '../sound.dart';
import 'quest.dart';

part 'quest_stage.g.dart';

/// A stage of a [Quest].
@JsonSerializable()
class QuestStage {
  /// Create an instance.
  QuestStage({
    required this.id,
    this.description,
    this.sound,
  });

  /// Create an instance from a JSON object.
  factory QuestStage.fromJson(final Map<String, dynamic> json) =>
      _$QuestStageFromJson(json);

  /// The ID of this stage.
  final String id;

  /// A textual description for this stage.
  ///
  /// This value will be shown to the user.
  String? description;

  /// The sound that will be played to the player when they focus on this quest
  /// in their quests list.
  Sound? sound;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$QuestStageToJson(this);
}
