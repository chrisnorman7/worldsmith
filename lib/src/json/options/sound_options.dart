/// Provides the [SoundOptions] class.
import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:json_annotation/json_annotation.dart';

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
    this.synthizerLogLevel,
    this.synthizerLoggingBackend,
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

  /// The logging level for synthizer.
  LogLevel? synthizerLogLevel;

  /// The synthizer logging backend to use.
  LoggingBackend? synthizerLoggingBackend;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$SoundOptionsToJson(this);
}
