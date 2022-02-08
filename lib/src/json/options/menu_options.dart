/// Provides the [MenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

part 'menu_options.g.dart';

/// A class for configuring a menu.
@JsonSerializable()
class MenuOptions {
  /// Create an instance.
  const MenuOptions({
    required this.title,
    this.musicId,
  });

  /// Create an instance from a JSON object.
  factory MenuOptions.fromJson(Map<String, dynamic> json) =>
      _$MenuOptionsFromJson(json);

  /// The title of this menu.
  final String title;

  /// The ID of the music that should play while in this menu.
  final String? musicId;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$MenuOptionsToJson(this);
}
