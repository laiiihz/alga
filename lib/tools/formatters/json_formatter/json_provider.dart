// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:alga/utils/constants/import_helper.dart';

import 'json_enums.dart';

part 'json_provider.g.dart';

final jsonIndentTypeProvider =
    StateProvider.autoDispose((ref) => JsonIndentType.space2);

final errorTextProvider = StateProvider.autoDispose<String?>((ref) => null);

@riverpod
RichTextController rawJsonController(RawJsonControllerRef ref) {
  final controller = RichTextController.lang(type: HighlightType.json);
  ref.onDispose(controller.dispose);
  controller.addListener(() => ref.invalidate(formattedJsonControllerProvider));
  return controller;
}

@riverpod
JsonFormatResult formattedJsonController(FormattedJsonControllerRef ref) {
  final controller = ref.watch(rawJsonControllerProvider);
  final indentation = ref.watch(jsonIndentTypeProvider);
  if (indentation == JsonIndentType.minified) {
    return JsonFormatResult(controller.text.trim().replaceAll('\n', ''));
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
      return JsonFormatResult(encoder.convert(rawMap));
    } catch (e) {
      return JsonFormatResult(controller.text, e.toString());
    }
  }
}

class JsonFormatResult {
  JsonFormatResult(this.data, [this.error]);

  final String? data;
  final String? error;

  @override
  bool operator ==(covariant JsonFormatResult other) {
    if (identical(this, other)) return true;

    return other.data == data && other.error == error;
  }

  @override
  int get hashCode => Object.hash(data, error);
}
