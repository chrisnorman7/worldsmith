/// Provides the [SceneSection] class.
import 'package:json_annotation/json_annotation.dart';

import '../messages/custom_message.dart';
import 'scene.dart';

part 'scene_section.g.dart';

/// A section in a [Scene].
@JsonSerializable()
class SceneSection {
  /// Create an instance.
  SceneSection({
    required this.message,
  });

  /// Create an instance from a JSON object.
  factory SceneSection.fromJson(final Map<String, dynamic> json) =>
      _$SceneSectionFromJson(json);

  /// The message that will be shown.
  final CustomMessage message;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$SceneSectionToJson(this);
}
