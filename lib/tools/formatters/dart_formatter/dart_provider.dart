import 'package:dart_style/dart_style.dart';

import 'package:alga/tools/formatters/formatter_abstract.dart';

class DartProvider implements FormatterAbstract {
  @override
  FormatResult onChanged(String text) {
    try {
      final formatter = DartFormatter();
      return FormatResult(formatter.format(text));
    } catch (e) {
      return FormatResult(text, e.toString());
    }
  }
}
