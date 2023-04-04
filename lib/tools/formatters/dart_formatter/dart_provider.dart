import 'package:alga/utils/constants/import_helper.dart';
import 'package:dart_style/dart_style.dart';

import 'package:alga/tools/formatters/formatter_abstract.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dart_provider.g.dart';

@riverpod
RichTextController dartInput(DartInputRef ref) {
  final controller = RichTextController.lang(type: HighlightType.dart);
  ref.onDispose(controller.dispose);
  controller.addListener(() => ref.invalidate(dartTextProvider));
  return controller;
}

@riverpod
String dartText(DartTextRef ref) => ref.watch(dartInputProvider).text;

@riverpod
FormatResult result(ResultRef ref) {
  final text = ref.watch(dartTextProvider);
  try {
    final formatter = DartFormatter();
    return FormatResult(formatter.format(text));
  } catch (e) {
    return FormatResult(text, e.toString());
  }
}
