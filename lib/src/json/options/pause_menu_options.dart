/// Provides the [PauseMenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../messages/custom_message.dart';
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
    CustomMessage? zoneOverviewMessage,
    CustomMessage? returnToGameMessage,
    CustomMessage? returnToMainMenuMessage,
    this.returnToMainMenuFadeTime = 3.0,
  })  : zoneOverviewMessage =
            zoneOverviewMessage ?? CustomMessage(text: 'Map Overview'),
        returnToGameMessage =
            returnToGameMessage ?? CustomMessage(text: 'Return To Game'),
        returnToMainMenuMessage = returnToMainMenuMessage ??
            CustomMessage(text: 'Return To Main Menu');

  /// Create an instance from a JSON object.
  factory PauseMenuOptions.fromJson(Map<String, dynamic> json) =>
      _$PauseMenuOptionsFromJson(json);

  /// The title of this menu.
  String title;

  /// The music to play while paused.
  Sound? music;

  /// The fade time.
  double? fadeTime;

  /// The message for the "Show Zone Map" item.
  final CustomMessage zoneOverviewMessage;

  /// The message for the "Return to game" menu item.
  final CustomMessage returnToGameMessage;

  /// The message to be used when returning to the main menu.
  final CustomMessage returnToMainMenuMessage;

  /// The fade time when returning to the main menu.
  double? returnToMainMenuFadeTime;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$PauseMenuOptionsToJson(this);
}
