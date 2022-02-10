/// Provides the [ReverbReference] class.
import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat/sound.dart';

part 'reverb_reference.g.dart';

/// A reference to a [ReverbPreset] instance.
@JsonSerializable()
class ReverbReference {
  /// Create an instance.
  const ReverbReference({required this.id, required this.reverbPreset});

  /// Create an instance from a JSON object.
  factory ReverbReference.fromJson(Map<String, dynamic> json) =>
      _$ReverbReferenceFromJson(json);

  /// The ID of this reverb.
  final String id;

  /// The reverb to use.
  final ReverbPreset reverbPreset;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ReverbReferenceToJson(this);
}
