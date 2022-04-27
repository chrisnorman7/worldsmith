/// Provides the [SceneSection] class.
import 'package:json_annotation/json_annotation.dart';

import '../sounds/sound.dart';
import 'scene.dart';

part 'scene_section.g.dart';

/// A section in a [Scene].
@JsonSerializable()
class SceneSection {
  /// Create an instance.
  SceneSection({
    this.text,
    this.sound,
  });

  /// Create an instance from a JSON object.
  factory SceneSection.fromJson(final Map<String, dynamic> json) =>
      _$SceneSectionFromJson(json);

  /// The message that will be shown.
  String? text;

  /// The sound that will be played.
  Sound? sound;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$SceneSectionToJson(this);
}
