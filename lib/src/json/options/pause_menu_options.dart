/// Provides the [PauseMenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../sound.dart';

part 'pause_menu_options.g.dart';

/// Configure the pause menu.
@JsonSerializable()
class PauseMenuOptions {
  /// Create an instance.
  PauseMenuOptions({
    this.title = 'Pause Menu',
    this.music,
    this.fadeTime,
    this.zoneOverviewLabel = 'Map Overview',
    this.returnToGameTitle = 'Return To Game',
  });

  /// Create an instance from a JSON object.
  factory PauseMenuOptions.fromJson(Map<String, dynamic> json) =>
      _$PauseMenuOptionsFromJson(json);

  /// The title of this menu.
  String title;

  /// The music to play while paused.
  Sound? music;

  /// The fade time.
  double? fadeTime;

  /// The label for the "Show Zone Map" item.
  String zoneOverviewLabel;

  /// The title of the "Return to game" menu item.
  String returnToGameTitle;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$PauseMenuOptionsToJson(this);
}
