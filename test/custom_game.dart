import 'package:ziggurat/ziggurat.dart';

/// A game that stores text.
class CustomGame extends Game {
  /// Create an instance.
  CustomGame(super.title) : strings = [];

  /// The stored messages.
  final List<String> strings;

  @override
  void outputText(final String text) => strings.add(text);
}
