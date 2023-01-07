part of './markdown_preview_view.dart';

final _inputController = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _inputValue =
    Provider.autoDispose<String>((ref) => ref.watch(_inputController).text);
