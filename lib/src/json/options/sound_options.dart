/// Provides the [SoundOptions] class.
import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat/sound.dart';

import '../sound.dart';

part 'sound_options.g.dart';

/// A class that configures game sound.
@JsonSerializable()
class SoundOptions {
  /// Create an instance.
  SoundOptions({
    this.defaultGain = 0.7,
    this.menuMoveSound,
    this.menuActivateSound,
    this.defaultPannerStrategy = DefaultPannerStrategy.stereo,
  });

  /// Create an instance from a JSON object.
  factory SoundOptions.fromJson(Map<String, dynamic> json) =>
      _$SoundOptionsFromJson(json);

  /// The default gain when no other gain is provided.
  double defaultGain;

  /// The sound to play when moving through menus.
  Sound? menuMoveSound;

  /// The sound to play when activating menu options.
  Sound? menuActivateSound;

  /// The default panning strategy for this game.
  DefaultPannerStrategy defaultPannerStrategy;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$SoundOptionsToJson(this);
}
