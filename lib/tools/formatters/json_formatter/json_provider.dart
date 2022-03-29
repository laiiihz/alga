import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:alga/tools/formatters/formatter_abstract.dart';
import 'json_enums.dart';

class JsonProvider extends ChangeNotifier implements FormatterAbstract {
  JsonIndentType _type = JsonIndentType.space2;

  JsonIndentType get type => _type;
  set type(JsonIndentType indentType) {
    _type = indentType;
    notifyListeners();
  }

  @override
  FormatResult onChanged(String text) {
    if (_type == JsonIndentType.minified) {
      return FormatResult(text.trim().replaceAll('\n', ''));
    }
    const decoder = JsonDecoder();
    try {
      final rawMap = decoder.convert(text);
      late JsonEncoder encoder;
      switch (_type) {
        case JsonIndentType.space2:
          encoder = JsonEncoder.withIndent(' ' * 2);
          break;
        case JsonIndentType.space4:
          encoder = JsonEncoder.withIndent(' ' * 4);
          break;
        case JsonIndentType.tab:
          encoder = const JsonEncoder.withIndent('\t');
          break;
        default:
          encoder = const JsonEncoder();
          break;
      }
      return FormatResult(encoder.convert(rawMap));
    } catch (e) {
      return FormatResult(text, e.toString());
    }
  }
}
