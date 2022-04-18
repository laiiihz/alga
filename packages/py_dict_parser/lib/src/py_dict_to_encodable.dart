import 'package:py_dict_parser/src/tunple_data.dart';

class ConvertList {
  final String tag;
  final List items;
  ConvertList({
    required this.tag,
    required this.items,
  });
}

class PyDict2Encodable {
  final String indent;
  final StringBuffer _buffer = StringBuffer();
  PyDict2Encodable([this.indent = '    ']);

  String encode(dynamic data) {
    writeCheckType(data, 0);
    return _buffer.toString();
  }

  writeString(String data) {
    _buffer.write('\'');
    _buffer.write(data);
    _buffer.write('\'');
  }

  writeNull() {
    _buffer.write('null');
  }

  writeNumber(num data) {
    _buffer.write(data);
  }

  writeBool(bool data) {
    _buffer.write(data ? 'true' : 'false');
  }

  writeList(List data, int deep) {
    if (data.isEmpty) {
      _buffer.write('[]');
      return;
    }
    _buffer.write('[');
    _buffer.write('\n');

    for (var i = 0; i < data.length; i++) {
      _buffer.write(indent * (deep + 1));
      writeCheckType(data[i], deep + 1);
      if (i != data.length - 1) _buffer.write(',');
      _buffer.write('\n');
    }

    _buffer.write(indent * deep);
    _buffer.write(']');
  }

  writeTunple(Tunple data, int deep) {
    final items = data.value;
    if (items.isEmpty) {
      _buffer.write('()');
      return;
    }

    _buffer.write('(');
    _buffer.write('\n');

    for (var i = 0; i < items.length; i++) {
      _buffer.write(indent * (deep + 1));
      writeCheckType(items[i], deep + 1);
      if (i != items.length - 1) _buffer.write(',');
      _buffer.write('\n');
    }

    _buffer.write(indent * deep);
    _buffer.write(')');
  }

  writeMap(Map data, int deep) {
    if (data.isEmpty) {
      _buffer.write('{}');
      return;
    }
    final items = data.entries.toList();
    _buffer.write('{');
    _buffer.write('\n');

    for (var i = 0; i < items.length; i++) {
      _buffer.write(indent * (deep + 1));
      writeString(items[i].key);
      _buffer.write(':');
      writeCheckType(items[i].value, deep + 1);
      if (i != data.length - 1) _buffer.write(',');
      _buffer.write('\n');
    }

    _buffer.write(indent * deep);
    _buffer.write('}');
  }

  writeCheckType(dynamic data, int deep) {
    if (data is String) {
      writeString(data);
    } else if (data is num) {
      writeNumber(data);
    } else if (data is bool) {
      writeBool(data);
    } else if (data is List) {
      writeList(data, deep);
    } else if (data is Map) {
      writeMap(data, deep);
    } else if (data is Tunple) {
      writeTunple(data, deep);
    } else {
      writeNull();
    }
  }
}
