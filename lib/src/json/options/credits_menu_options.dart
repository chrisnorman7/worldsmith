/// Provides the [CreditsMenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../sound.dart';

part 'credits_menu_options.g.dart';

/// Configuration for the credits menu.
@JsonSerializable()
class CreditsMenuOptions {
  /// Create an instance.
  const CreditsMenuOptions({
    this.title = 'Acknowledgements',
    this.music,
    this.fadeTime = 3.0,
  });

  /// Create an instance from a JSON object.
  factory CreditsMenuOptions.fromJson(Map<String, dynamic> json) =>
      _$CreditsMenuOptionsFromJson(json);

  /// The title of the menu.
  final String title;

  /// The music to play.
  final Sound? music;

  /// How long to fade out after showing this menu.
  final double? fadeTime;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$CreditsMenuOptionsToJson(this);
}
