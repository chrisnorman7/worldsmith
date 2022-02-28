import 'package:json_annotation/json_annotation.dart';

import '../sound.dart';

part 'sound_menu_options.g.dart';

/// Configuration for the sound options menu.
@JsonSerializable()
class SoundMenuOptions {
  /// Create an instance.
  SoundMenuOptions({
    this.title = 'Configure Sound',
    this.fadeTime,
    this.music,
    this.gainAdjust = 0.1,
    this.interfaceSoundsVolumeTitle = 'Interface Sounds Volume',
    this.musicVolumeTitle = 'Music Volume',
    this.ambianceSoundsVolumeTitle = 'Ambiance Sounds Volume',
  });

  /// Create an instance from a JSON object.
  factory SoundMenuOptions.fromJson(Map<String, dynamic> json) =>
      _$SoundMenuOptionsFromJson(json);

  /// The title of the menu.
  String title;

  /// The music to play.
  Sound? music;

  /// How long to fade out after showing this menu.
  double? fadeTime;

  /// How much the gains should be changed by.
  double gainAdjust;

  /// The title of the "Interface Sounds Volume" option.
  String interfaceSoundsVolumeTitle;

  /// The title of the "Music Volume" option.
  String musicVolumeTitle;

  /// The title of the "Ambiance Sounds Volume" option.
  String ambianceSoundsVolumeTitle;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$SoundMenuOptionsToJson(this);
}