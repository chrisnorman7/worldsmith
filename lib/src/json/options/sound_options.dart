/// Provides the [SoundOptions] class.
import 'package:json_annotation/json_annotation.dart';

part 'sound_options.g.dart';

/// A class that configures game sound.
@JsonSerializable()
class SoundOptions {
  /// Create an instance.
  const SoundOptions({
    this.menuMoveSoundId,
    this.menuActivateSoundId,
  });

  /// Create an instance from a JSON object.
  factory SoundOptions.fromJson(Map<String, dynamic> json) =>
      _$SoundOptionsFromJson(json);

  /// The ID of the menu move sound from the interface sounds asset store.
  final String? menuMoveSoundId;

  /// The ID of the menu activate sound from the interface sounds asset store.
  final String? menuActivateSoundId;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$SoundOptionsToJson(this);
}
