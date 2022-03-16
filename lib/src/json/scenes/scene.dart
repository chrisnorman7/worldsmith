/// Provides the [Scene] class.
import 'package:json_annotation/json_annotation.dart';

import 'scene_section.dart';

part 'scene.g.dart';

/// A scene to show to the player.
///
/// Scenes can have 0 or more [sections], although 0 sections makes very little
/// sense.
@JsonSerializable()
class Scene {
  /// Create an instance.
  Scene({
    required this.id,
    required this.name,
    required this.sections,
  });

  /// Create an instance from a JSON object.
  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);

  /// The ID of this scene.
  final String id;

  /// The name of this scene.
  String name;

  /// The sections that will be shown as part of this scene.
  final List<SceneSection> sections;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$SceneToJson(this);
}
