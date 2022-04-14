part of './markdown_preview_view.dart';

final _inputController =
    StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

final _inputValue = StateProvider.autoDispose<String>((ref) {
  return ref.read(_inputController).text;
});

class MarkdownPreviewProvider extends ChangeNotifier {
  final markdownController = TextEditingController();

  String _data = '';
  String get data => _data;
  set data(String value) {
    _data = value;
    notifyListeners();
  }

  copy() {
    ClipboardUtil.copy(markdownController.text);
  }

  clear() {
    markdownController.clear();
    convert();
  }

  convert() {
    data = markdownController.text;
  }

  @override
  dispose() {
    markdownController.dispose();
    super.dispose();
  }
}
