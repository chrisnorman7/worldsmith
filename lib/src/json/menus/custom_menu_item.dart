/// Provides the [CustomMenuItem] class.
import 'package:json_annotation/json_annotation.dart';

import '../commands/call_command.dart';
import '../sounds/sound.dart';
import 'custom_menu.dart';

part 'custom_menu_item.g.dart';

/// A menu item in a [CustomMenu] instance.
@JsonSerializable()
class CustomMenuItem {
  /// Create an instance.
  CustomMenuItem({
    required this.id,
    this.label,
    this.sound,
    this.activateCommand,
  });

  /// Create an instance from a JSON object.
  factory CustomMenuItem.fromJson(final Map<String, dynamic> json) =>
      _$CustomMenuItemFromJson(json);

  /// The ID for this menu item.
  final String id;

  /// The text of this item.
  String? label;

  /// The sound that should play when this item is focused.
  Sound? sound;

  /// The command to call when this item is activated.
  CallCommand? activateCommand;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$CustomMenuItemToJson(this);
}
