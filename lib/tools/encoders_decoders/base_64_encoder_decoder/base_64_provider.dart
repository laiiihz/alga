import 'dart:convert';
import 'dart:typed_data';

import 'package:devtoys/utils/clipboard_util.dart';
import 'package:flutter/material.dart';

class Base64Provider extends ChangeNotifier {
  bool _isEncode = true;
  bool get isEncode => _isEncode;
  set isEncode(bool state) {
    _isEncode = state;
    notifyListeners();
  }

  final inputController = TextEditingController();
  final outputController = TextEditingController();

  clear() {
    inputController.clear();
    outputController.clear();
  }

  paste() async {
    inputController.text = await ClipboardUtil.paste();
    convert();
  }

  copy() async {
    ClipboardUtil.copy(outputController.text);
  }

  convert() {
    if (_isEncode) {
      final result =
          const Base64Encoder().convert(inputController.text.codeUnits);
      outputController.text = result;
    } else {
      try {
        Uint8List result = base64.decode(inputController.text);
        outputController.text = String.fromCharCodes(result);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }
}
