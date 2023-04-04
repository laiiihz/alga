abstract class FormatterAbstract {
  FormatResult onChanged(String text);
}

class FormatResult {
  final String? result;
  final String? errorReson;
  const FormatResult(this.result, [this.errorReson]);
}
