/// Provides the [PauseMenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../sounds/sound.dart';

part 'pause_menu_options.g.dart';

/// Configure the pause menu.
@JsonSerializable()
class PauseMenuOptions {
  /// Create an instance.
  PauseMenuOptions({
    this.title = 'Pause Menu',
    this.music,
    this.fadeTime,
    this.zoneOverviewString = 'Show Map',
    this.zoneOverviewSound,
    this.returnToGameString = 'Return To Game',
    this.returnToGameSound,
    this.returnToMainMenuString = 'Return To Main Menu',
    this.returnToMainMenuSound,
    this.returnToMainMenuFadeTime = 3.0,
  });

  /// Create an instance from a JSON object.
  factory PauseMenuOptions.fromJson(final Map<String, dynamic> json) =>
      _$PauseMenuOptionsFromJson(json);

  /// The title of this menu.
  String title;

  /// The music to play while paused.
  Sound? music;

  /// The fade time.
  double? fadeTime;

  /// The message for the "Show Zone Map" item.
  String? zoneOverviewString;

  /// The sound for the "Show Zone Map" item.
  Sound? zoneOverviewSound;

  /// The message for the "Return to game" menu item.
  String? returnToGameString;

  /// The sound for the "Return to game" menu item.
  Sound? returnToGameSound;

  /// The message to be used when returning to the main menu.
  String? returnToMainMenuString;

  /// The sound to be used when returning to the main menu.
  Sound? returnToMainMenuSound;

  /// The fade time when returning to the main menu.
  double? returnToMainMenuFadeTime;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$PauseMenuOptionsToJson(this);
}
