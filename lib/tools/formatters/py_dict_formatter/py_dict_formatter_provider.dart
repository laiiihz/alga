part of './py_dict_formatter_view.dart';

class PyDictProvider implements FormatterAbstract {
  PyDictProvider();
  @override
  FormatResult onChanged(String text) {
    try {
      final PyDictEncoder _pyDictEncoder = PyDictEncoder();
      final PyDictDecoder _pyDictDecoder = PyDictDecoder();
      final data = _pyDictDecoder.decode(text);
      return FormatResult(_pyDictEncoder.encode(data));
    } catch (e) {
      return FormatResult(text, e.toString());
    }
  }
}
