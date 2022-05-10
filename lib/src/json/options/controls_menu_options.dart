/// Provides the [ControlsMenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../sounds/sound.dart';

part 'controls_menu_options.g.dart';

/// The options for the controls menu.
@JsonSerializable()
class ControlsMenuOptions {
  /// Create an instance.
  ControlsMenuOptions({
    this.title = 'Game Controls',
    this.music,
    this.ambianceFadeTime,
    this.itemSound,
    this.subMenuTitle = 'Controls',
    this.gameControllerButtonPrefix = 'Game Controller Button: ',
    this.emptyGameControllerButtonMessage = '<Not Set>',
    this.keyboardControlPrefix = 'Keyboard Keys: ',
    this.emptyKeyboardControlMessage = '<Not Set>',
  });

  /// Create an instance from a JSON object.
  factory ControlsMenuOptions.fromJson(final Map<String, dynamic> json) =>
      _$ControlsMenuOptionsFromJson(json);

  /// The title of the menu.
  String title;

  /// The music to play in the menu.
  Sound? music;

  /// The ambiance fade time to use.
  double? ambianceFadeTime;

  /// The sound to play for each control entry.
  Sound? itemSound;

  /// The title of the control submenu.
  String subMenuTitle;

  /// The text to put before game controller buttons.
  String gameControllerButtonPrefix;

  /// The text to show if there is no game controller button.
  String emptyGameControllerButtonMessage;

  /// The text to put before the keyboard controls.
  String keyboardControlPrefix;

  /// The string to show if there is no keyboard control.
  String emptyKeyboardControlMessage;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ControlsMenuOptionsToJson(this);
}
