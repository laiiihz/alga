part of './markdown_preview_view.dart';

final _inputController = Provider.autoDispose<RichTextController>((ref) {
  final controller = RichTextController.lang(type: HighlightType.markdown);
  ref.onDispose(controller.dispose);
  return controller;
});

final _inputValue =
    Provider.autoDispose<String>((ref) => ref.watch(_inputController).text);
