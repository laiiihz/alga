import 'package:alga/constants/import_helper.dart';
import 'package:language_textfield/lang_special_builder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'regex_tester_text_builder.dart';

part 'regex_tester_provider.g.dart';

final regexMultiLine = StateProvider.autoDispose<bool>((ref) => false);
final regexCaseSensitive = StateProvider.autoDispose<bool>((ref) => true);
final regexUnicode = StateProvider.autoDispose<bool>((ref) => false);
final regexDotAll = StateProvider.autoDispose<bool>((ref) => false);

/// can not watch other provider
@riverpod
RichTextController regexExpression(RegexExpressionRef ref) {
  final controller = RichTextController(builder: LanguageBuilder.regex);
  controller.addListener(() => ref.refresh(regexValueProvider));
  ref.onDispose(controller.dispose);
  return controller;
}

@riverpod
RegExpValue regexValue(RegexValueRef ref) {
  try {
    final text = ref.watch(regexExpressionProvider).text;
    if (text.isEmpty) return const RegExpValue();
    final regex = RegExp(
      text,
      multiLine: ref.watch(regexMultiLine),
      caseSensitive: ref.watch(regexCaseSensitive),
      unicode: ref.watch(regexUnicode),
      dotAll: ref.watch(regexDotAll),
    );
    return RegExpValue(value: regex);
  } on FormatException catch (e) {
    return RegExpValue(error: e);
  }
}

@riverpod
RichTextController regexInputController(RegexInputControllerRef ref) {
  final controller = RichTextController();
  ref.onDispose(controller.dispose);
  ref.listen(regexValueProvider, (previous, next) {
    controller.updateBuilder(RegexTesterBuilder(next.value));
  });
  return controller;
}

class RegExpValue {
  const RegExpValue({this.value, this.error});

  final RegExp? value;
  final FormatException? error;

  bool get hasError => error != null;
  bool get hasExp => value != null;
}
