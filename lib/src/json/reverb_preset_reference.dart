/// Provides the [ReverbPresetReference] class.
import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat/sound.dart';

import 'sounds/custom_sound.dart';

part 'reverb_preset_reference.g.dart';

/// A reference to a [ReverbPreset] instance.
@JsonSerializable()
class ReverbPresetReference {
  /// Create an instance.
  ReverbPresetReference({
    required this.id,
    required this.reverbPreset,
    this.sound,
  });

  /// Create an instance from a JSON object.
  factory ReverbPresetReference.fromJson(final Map<String, dynamic> json) =>
      _$ReverbPresetReferenceFromJson(json);

  /// The ID of this reverb.
  final String id;

  /// The reverb to use.
  ReverbPreset reverbPreset;

  /// The sound to test the reverb with.
  CustomSound? sound;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ReverbPresetReferenceToJson(this);
}
