

part of './json_yaml_converter_view.dart';

final _jsonController = StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});
final _yamlController = StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});


class JsonYamlUtil {
  static json2yaml(WidgetRef ref) {
    try {
      ref.read(_yamlController).text =
          json_2_yaml.json2yaml(json.decode(ref.read(_jsonController).text));
    } catch (e) {
      return;
    }
  }

  static yaml2json(WidgetRef ref) {
    try {
      final result = loadYaml(ref.read(_yamlController).text);
      if (result is YamlMap || result is YamlList) {
        ref.read(_jsonController).text = formatJson(result);
      } else {
        ref.read(_jsonController).text = 'unknown yaml';
      }
    } catch (e) {
      return;
    }
  }

  static String formatJson(Map map) {
    final JsonEncoder jsonEncoder = JsonEncoder.withIndent(' ' * 4);
    return jsonEncoder.convert(map);
  }
}
