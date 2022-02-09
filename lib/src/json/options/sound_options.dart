/// Provides the [SoundOptions] class.
import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat/sound.dart';

import '../sound.dart';

part 'sound_options.g.dart';

/// A class that configures game sound.
@JsonSerializable()
class SoundOptions {
  /// Create an instance.
  const SoundOptions({
    this.menuMoveSound,
    this.menuActivateSound,
    this.defaultPannerStrategy = DefaultPannerStrategy.stereo,
  });

  /// Create an instance from a JSON object.
  factory SoundOptions.fromJson(Map<String, dynamic> json) =>
      _$SoundOptionsFromJson(json);

  /// The sound to play when moving through menus.
  final Sound? menuMoveSound;

  /// The sound to play when activating menu options.
  final Sound? menuActivateSound;

  /// The default panning strategy for this game.
  final DefaultPannerStrategy defaultPannerStrategy;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$SoundOptionsToJson(this);
}
