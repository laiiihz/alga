part of 'common_converter.dart';

enum ConverterType {
  json,
  yaml,
  toml,
  ;

  HighlightType get highlighter => switch (this) {
        json => HighlightType.json,
        yaml => HighlightType.yaml,
        toml => HighlightType.toml,
      };

  String encode(dynamic data) {
    const jEncoder = JsonEncoder.withIndent('  ');
    switch (this) {
      case json:
        return jEncoder.convert(data);
      case yaml:
        return json2yaml(data);
      case toml:
        return TomlDocument.fromMap(data).toString();
    }
  }

  dynamic decode(String data) {
    const jDecoder = JsonDecoder();
    switch (this) {
      case json:
        return jDecoder.convert(data);
      case yaml:
        final doc = loadYaml(data);
        final str = const JsonEncoder.withIndent('  ').convert(doc);
        return jDecoder.convert(str);
      case toml:
        return TomlDocument.parse(data).toMap();
    }
  }

  String format(String text) {
    return encode(decode(text));
  }
}

@riverpod
class InputType extends _$InputType {
  @override
  ConverterType build() => ConverterType.json;

  void change(ConverterType type) {
    state = type;
  }
}

@riverpod
class OutputType extends _$OutputType {
  @override
  ConverterType build() => ConverterType.yaml;

  void change(ConverterType type) {
    state = type;
  }
}

@riverpod
FutureOr<(String, String?)> _result(_ResultRef ref) async {
  final content = ref.watch(_useContent);
  if (content.isEmpty) return ('', null);
  final inputType = ref.watch(inputTypeProvider);
  final outputType = ref.watch(outputTypeProvider);

  try {
    final params = (inputType, outputType, content);
    if (content.length <= 4000) {
      return (_decode(params), null);
    } else {
      return (await compute(_decode, params), null);
    }
  } catch (e) {
    return ('', e.toString());
  }
}

String _decode(
    (ConverterType input, ConverterType output, String content) params) {
  final middleware = params.$1.decode(params.$3);
  return params.$2.encode(middleware);
}
