library py_dict_parser;

import 'package:petitparser/petitparser.dart';
import 'package:py_dict_parser/src/parser.dart';
import 'package:py_dict_parser/src/py_dict_to_encodable.dart';

class PyDictDecoder {
  final Parser _parser;
  PyDictDecoder() : _parser = PyDictParserDefinition().build();
  dynamic decode(String data) {
    final result = _parser.parse(data);
    return result.value;
  }
}

class PyDictEncoder {
  final PyDict2Encodable _pyDict2Encodable;
  PyDictEncoder([String indent = '    '])
      : _pyDict2Encodable = PyDict2Encodable(indent);
  String encode(dynamic data) {
    return _pyDict2Encodable.encode(data);
  }
}
