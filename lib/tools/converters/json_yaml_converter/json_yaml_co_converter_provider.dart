import 'dart:convert';

import 'package:alga/constants/import_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'json_yaml_co_converter_provider.g.dart';

// @riverpod
// RichTextController jsonCVTController(JsonCVTControllerRef ref) {
//   final controller = RichTextController.lang(type: HighlightType.json);
//   ref.listen(yamlCVTControllerProvider, (_, next) {});
//   ref.onDispose(controller.dispose);
//   return controller;
// }

enum JsonYamlType {
  json,
  yaml,
  loading,
}

@riverpod
RichTextController yamlCVTController(YamlCVTControllerRef ref) {
  final controller = RichTextController.lang(type: HighlightType.yaml);
  ref.listen(jsonCVTControllerProvider, (_, next) {});
  ref.onDispose(controller.dispose);
  return controller;
}

@riverpod
class JsonCVTController extends _$JsonCVTController {
  @override
  RichTextController build() {
    final controller = RichTextController.lang(type: HighlightType.json);
    ref.onDispose(controller.dispose);
    return controller;
  }

  format() {
    if (state.text.isEmpty) return;
    final obj = json.decode(state.text);
    state.text = JsonEncoder.withIndent(' ' * 4).convert(obj);
  }
}

final jsonYamlTypeProvider =
    StateProvider.autoDispose((ref) => JsonYamlType.json);
