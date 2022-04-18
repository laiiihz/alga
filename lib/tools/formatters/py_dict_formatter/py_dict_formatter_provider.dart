part of './py_dict_formatter_view.dart';

class PyDictProvider implements FormatterAbstract {
  final PyDictEncoder _pyDictEncoder;
  final PyDictDecoder _pyDictDecoder;
  PyDictProvider()
      : _pyDictEncoder = PyDictEncoder(),
        _pyDictDecoder = PyDictDecoder();
  @override
  FormatResult onChanged(String text) {
    try {
      final data = _pyDictDecoder.decode(text);
      return FormatResult(_pyDictEncoder.encode(data));
    } catch (e) {
      return FormatResult(text, e.toString());
    }
  }
}
