/// Provides the [ShowScene] class.
import 'package:json_annotation/json_annotation.dart';

import '../commands/call_command.dart';

part 'show_scene.g.dart';

/// A command to show a scene.
@JsonSerializable()
class ShowScene {
  /// Create an instance.
  ShowScene({
    required this.sceneId,
    this.callCommand,
  });

  /// Create an instance from a JSON object.
  factory ShowScene.fromJson(Map<String, dynamic> json) =>
      _$ShowSceneFromJson(json);

  /// The ID of the scene to show.
  String sceneId;

  /// The command to call after this scene has finished.
  CallCommand? callCommand;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ShowSceneToJson(this);
}
