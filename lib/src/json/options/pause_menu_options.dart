/// Provides the [PauseMenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../sound.dart';

part 'pause_menu_options.g.dart';

/// Configure the pause menu.
@JsonSerializable()
class PauseMenuOptions {
  /// Create an instance.
  const PauseMenuOptions({
    this.title = 'Pause Menu',
    this.music,
    this.fadeTime,
    this.returnToGameTitle = 'Return To Game',
  });

  /// Create an instance from a JSON object.
  factory PauseMenuOptions.fromJson(Map<String, dynamic> json) =>
      _$PauseMenuOptionsFromJson(json);

  /// The title of this menu.
  final String title;

  /// The music to play while paused.
  final Sound? music;

  /// The fade time.
  final double? fadeTime;

  /// The title of the "Return to game" menu item.
  final String returnToGameTitle;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$PauseMenuOptionsToJson(this);
}
