/// Provides the [WorldCredit] class.
import 'package:json_annotation/json_annotation.dart';

import 'sounds/sound.dart';

part 'world_credit.g.dart';

/// A credit for the game.
///
/// Instances of this class will be used to generate a credits menu.
@JsonSerializable()
class WorldCredit {
  /// Create an instance.
  WorldCredit({required this.id, required this.title, this.url, this.sound});

  /// Create an instance from a JSON object.
  factory WorldCredit.fromJson(final Map<String, dynamic> json) =>
      _$WorldCreditFromJson(json);

  /// The ID of this credit.
  final String id;

  /// The title of this credit.
  String title;

  /// The URL to open when this credit is clicked.
  String? url;

  /// The sound for this credit.
  Sound? sound;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldCreditToJson(this);
}
