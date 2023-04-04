// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alga/tools/formatters/formatter_abstract.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:alga/utils/constants/import_helper.dart';

import 'json_enums.dart';

part 'json_provider.g.dart';

@riverpod
class JsonIndent extends _$JsonIndent {
  @override
  JsonIndentType build() => JsonIndentType.space2;

  update(JsonIndentType state) => this.state = state;
}

final errorTextProvider = StateProvider.autoDispose<String?>((ref) => null);

@riverpod
RichTextController rawJsonController(RawJsonControllerRef ref) {
  final controller = RichTextController.lang(type: HighlightType.json);
  ref.onDispose(controller.dispose);
  controller.addListener(() => ref.invalidate(formattedJsonControllerProvider));
  return controller;
}

@riverpod
FormatResult formattedJsonController(FormattedJsonControllerRef ref) {
  final controller = ref.watch(rawJsonControllerProvider);
  final indentation = ref.watch(jsonIndentProvider);
  if (indentation == JsonIndentType.minified) {
    return FormatResult(controller.text.trim().replaceAll('\n', ''));
  } else {
    const decoder = JsonDecoder();
    try {
      final rawMap = decoder.convert(controller.text);
      late JsonEncoder encoder;
      switch (indentation) {
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
          break;
      }
      return FormatResult(encoder.convert(rawMap));
    } catch (e) {
      return FormatResult(controller.text, e.toString());
    }
  }
}
