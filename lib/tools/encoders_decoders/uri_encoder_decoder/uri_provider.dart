import 'package:devtoys/utils/clipboard_util.dart';
import 'package:flutter/material.dart';

class UriProvider extends ChangeNotifier {
  final inputController = TextEditingController();
  final outputController = TextEditingController();

  bool _isEncode = true;
  bool get isEncode => _isEncode;
  set isEncode(bool state) {
    _isEncode = state;
    notifyListeners();
  }

  clear() {
    inputController.clear();
    outputController.clear();
  }

  paste() async {
    inputController.text = await ClipboardUtil.paste();
    convert();
  }

  copy() async {
    await ClipboardUtil.copy(outputController.text);
  }

  convert() {
    outputController.text = _isEncode
        ? Uri.encodeFull(inputController.text)
        : Uri.decodeFull(inputController.text);
  }

  @override
  void dispose() {
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }
}
