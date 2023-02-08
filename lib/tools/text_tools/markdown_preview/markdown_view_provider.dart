import 'package:language_textfield/language_textfield.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'markdown_view_provider.g.dart';

@riverpod
RichTextController markdownController(MarkdownControllerRef ref) {
  final controller = RichTextController.lang(type: HighlightType.markdown);
  controller.addListener(() => ref.refresh(markdownValueProvider));
  ref.onDispose(controller.dispose);
  return controller;
}

@riverpod
String markdownValue(MarkdownValueRef ref) =>
    ref.watch(markdownControllerProvider).text;
