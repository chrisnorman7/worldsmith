import 'package:json_annotation/json_annotation.dart';

import 'custom_sound.dart';

part 'custom_message.g.dart';

/// A message which can display text and play a sound.
@JsonSerializable()
class CustomMessage {
  /// Create an instance.
  CustomMessage({this.text, this.sound});

  /// Create an instance from a JSON object.
  factory CustomMessage.fromJson(final Map<String, dynamic> json) =>
      _$CustomMessageFromJson(json);

  /// The text to show.
  String? text;

  /// The sound to play.
  CustomSound? sound;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$CustomMessageToJson(this);
}
