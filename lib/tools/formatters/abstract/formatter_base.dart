import 'package:fluent_ui/fluent_ui.dart';

typedef ConfigBuilder<T> = String Function(T typedData, String raw);

/// [T] is midware type
abstract class FormatterBase<T> {
  String title = '';

  TextEditingController inputController = TextEditingController();
  TextEditingController outputController = TextEditingController();

  @mustCallSuper
  clearAll() {
    inputController.clear();
    outputController.clear();
  }

  @mustCallSuper
  dispose() {
    inputController.dispose();
    outputController.dispose();
  }

  String get inputText => inputController.text;
  String get outputText => outputController.text;
  set inputText(String text) => inputController.text = text;
  set outputText(String text) => outputController.text = text;

  T decode(String raw);

  convertIt() {
    String text = inputText;
    final decoded = decode(text);
    for (var item in configs) {
      text = item(decoded, text);
    }
    outputText = text;
  }

  List<ConfigBuilder<T>> configs = [];
}
