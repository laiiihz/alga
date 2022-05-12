part of './py_dict_formatter_view.dart';

class PyDictProvider implements FormatterAbstract {
  PyDictProvider();
  @override
  FormatResult onChanged(String text) {
    try {
      final PyDictEncoder pyDictEncoder = PyDictEncoder();
      final PyDictDecoder pyDictDecoder = PyDictDecoder();
      final data = pyDictDecoder.decode(text);
      return FormatResult(pyDictEncoder.encode(data));
    } catch (e) {
      return FormatResult(text, e.toString());
    }
  }
}
