import 'package:ziggurat/ziggurat.dart';

/// A game that stores text.
class CustomGame extends Game {
  /// Create an instance.
  CustomGame(String title)
      : strings = [],
        super(title);

  /// The stored messages.
  final List<String> strings;

  @override
  void outputText(String text) => strings.add(text);
}
