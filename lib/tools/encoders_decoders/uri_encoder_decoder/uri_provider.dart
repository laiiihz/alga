import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/material.dart';

class UriProvider extends ChangeNotifier {
  final inputController = TextEditingController();
  String _uriResult = '';
  String get uriResult => _uriResult;
  set uriResult(String state) {
    _uriResult = state;
    notifyListeners();
  }

  bool _isEncode = true;
  bool get isEncode => _isEncode;
  set isEncode(bool state) {
    _isEncode = state;
    notifyListeners();
  }

  clear() {
    inputController.clear();
    uriResult = '';
  }

  paste() async {
    inputController.text = await ClipboardUtil.paste();
    convert();
  }

  copy() async {
    await ClipboardUtil.copy(uriResult);
  }

  convert() {
    uriResult = _isEncode
        ? Uri.encodeFull(inputController.text)
        : Uri.decodeFull(inputController.text);
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}
