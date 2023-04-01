import 'dart:convert';

import 'package:alga/utils/constants/import_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:json2yaml/json2yaml.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yaml/yaml.dart';

part 'json_yaml_co_converter_provider.g.dart';

enum JsonYamlType {
  json,
  yaml,
}

@riverpod
class JsonLoading extends _$JsonLoading {
  @override
  bool build() => false;
  update(bool state) => this.state = state;
}

@riverpod
class YamlLoading extends _$YamlLoading {
  @override
  bool build() => false;
  update(bool state) => this.state = state;
}

@riverpod
class JsonError extends _$JsonError {
  @override
  String? build() => null;
  update(String? state) => this.state = state;
}

@riverpod
class YamlError extends _$YamlError {
  @override
  String? build() => null;
  update(String? state) => this.state = state;
}

@riverpod
bool processing(ProcessingRef ref) {
  return ref.watch(jsonLoadingProvider) || ref.watch(yamlLoadingProvider);
}

@riverpod
class JsonCVTController extends _$JsonCVTController {
  @override
  RichTextController build() {
    final controller = RichTextController.lang(type: HighlightType.json);
    controller.addListener(() {
      ref.read(jsonErrorProvider.notifier).update(null);
    });
    ref.onDispose(controller.dispose);
    return controller;
  }

  format() async {
    if (state.text.isEmpty) return;
    ref.read(jsonLoadingProvider.notifier).update(true);
    state.text = await compute(_jsonFormat, state.text);
    ref.read(jsonLoadingProvider.notifier).update(false);
  }

  convert2yaml() async {
    if (state.text.isEmpty) {
      ref
          .read(jsonYamlTypeProvider.notifier)
          .update((state) => JsonYamlType.yaml);
      return;
    }
    ref.read(jsonLoadingProvider.notifier).update(true);
    try {
      final text = await compute(_json2yaml, state.text);
      ref
          .read(jsonYamlTypeProvider.notifier)
          .update((state) => JsonYamlType.yaml);
      ref.read(yamlCVTControllerProvider.notifier).updateText(text);
    } catch (e) {
      if (e is FormatException) {
        ref.read(jsonErrorProvider.notifier).update(e.message);
      } else {
        ref.read(jsonErrorProvider.notifier).update(e.toString());
      }
    }
    ref.read(jsonLoadingProvider.notifier).update(false);
  }

  updateText(String text) {
    state.text = text;
  }
}

@riverpod
class YamlCVTController extends _$YamlCVTController {
  @override
  RichTextController build() {
    final controller = RichTextController.lang(type: HighlightType.yaml);
    controller.addListener(() {
      ref.read(yamlErrorProvider.notifier).update(null);
    });
    ref.onDispose(controller.dispose);
    return controller;
  }

  format() {
    if (state.text.isEmpty) return;
    final obj = loadYaml(state.text);
    state.text = json2yaml(obj);
  }

  convert2json() async {
    if (state.text.isEmpty) {
      ref
          .read(jsonYamlTypeProvider.notifier)
          .update((state) => JsonYamlType.json);
      return;
    }
    ref.read(yamlLoadingProvider.notifier).update(true);
    try {
      final text = await compute(_yaml2json, state.text);
      ref
          .read(jsonYamlTypeProvider.notifier)
          .update((state) => JsonYamlType.json);
      ref.read(jsonCVTControllerProvider.notifier).updateText(text);
    } catch (e) {
      if (e is FormatException) {
        ref.read(yamlErrorProvider.notifier).update(e.message);
      } else {
        ref.read(yamlErrorProvider.notifier).update(e.toString());
      }
    }
    ref.read(yamlLoadingProvider.notifier).update(false);
  }

  updateText(String text) {
    state.text = text;
  }
}

final jsonYamlTypeProvider =
    StateProvider.autoDispose((ref) => JsonYamlType.json);

String _json2yaml(String text) {
  final obj = json.decode(text);
  return json2yaml(obj);
}

String _yaml2json(String text) {
  final obj = loadYaml(text);
  if (obj is YamlMap || obj is YamlList) {
    final JsonEncoder jsonEncoder = JsonEncoder.withIndent(' ' * 4);
    return jsonEncoder.convert(obj);
  }
  throw const FormatException('Unexpected Character');
}

String _jsonFormat(String text) {
  final obj = json.decode(text);
  return JsonEncoder.withIndent(' ' * 4).convert(obj);
}
