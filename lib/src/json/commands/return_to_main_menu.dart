/// Provides the [ReturnToMainMenu] class.
import 'package:json_annotation/json_annotation.dart';

part 'return_to_main_menu.g.dart';

/// An instruction to return to the main menu.
@JsonSerializable()
class ReturnToMainMenu {
  /// Create an instance.
  ReturnToMainMenu({
    this.fadeTime,
  });

  /// Create an instance from a JSON object.
  factory ReturnToMainMenu.fromJson(Map<String, dynamic> json) =>
      _$ReturnToMainMenuFromJson(json);

  /// The fade time to use.
  double? fadeTime;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ReturnToMainMenuToJson(this);
}
