import 'dart:convert';

import '../abstract/formatter_base.dart';
import 'formatter_json_view.dart';



class JsonFormatterBase extends FormatterBase<Map<String, dynamic>> {
  @override
  Map<String, dynamic> decode(String raw) => json.decode(raw);

  @override
  set configs(List<ConfigBuilder<Map<String, dynamic>>> _configs) {
    super.configs = _configs;
  }

  static ConfigBuilder<Map<String, dynamic>> jsonIdent(JsonIndentType type) {
    return (typedData, raw) {
      String indent = '';
      switch (type) {
        case JsonIndentType.space2:
          indent = ' ' * 2;
          break;
        case JsonIndentType.space4:
          indent = ' ' * 4;
          break;
        case JsonIndentType.tab:
          indent = '\t';
          break;
        default:
          break;
      }
      final encoder = JsonEncoder.withIndent(indent);
      if (type == JsonIndentType.zip) {
        return raw.trim().replaceAll('\n', '');
      }
      return encoder.convert(typedData);
    };
  }
}
