/// Provides the [Quest] class.
import 'package:json_annotation/json_annotation.dart';

import 'quest_stage.dart';

part 'quest.g.dart';

/// A quest with a list of [stages].
@JsonSerializable()
class Quest {
  /// Create an instance.
  Quest({
    required this.id,
    required this.name,
    required this.stages,
  });

  /// Create an instance from a JSON object.
  factory Quest.fromJson(Map<String, dynamic> json) => _$QuestFromJson(json);

  /// The ID of this quest.
  final String id;

  /// The name of this quest.
  String name;

  /// The stages of this quest.
  final List<QuestStage> stages;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$QuestToJson(this);
}
