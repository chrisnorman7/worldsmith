/// Provides the [CreditsMenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../sound.dart';

part 'credits_menu_options.g.dart';

/// Configuration for the credits menu.
@JsonSerializable()
class CreditsMenuOptions {
  /// Create an instance.
  CreditsMenuOptions({
    this.title = 'Acknowledgements',
    this.music,
    this.fadeTime = 3.0,
    this.zoneOverviewLabel = 'Zone Overview',
  });

  /// Create an instance from a JSON object.
  factory CreditsMenuOptions.fromJson(Map<String, dynamic> json) =>
      _$CreditsMenuOptionsFromJson(json);

  /// The title of the menu.
  String title;

  /// The music to play.
  Sound? music;

  /// How long to fade out after showing this menu.
  double? fadeTime;

  /// The label for the "Show Zone Map" item.
  final String zoneOverviewLabel;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$CreditsMenuOptionsToJson(this);
}
