import 'dart:convert';
import 'dart:typed_data';

import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/material.dart';

class Base64Provider extends ChangeNotifier {
  bool _isEncode = true;
  bool get isEncode => _isEncode;
  String _base64Result = '';
  String get base64Result => _base64Result;
  set base64Result(String state) {
    _base64Result = state;
    notifyListeners();
  }

  set isEncode(bool state) {
    _isEncode = state;
    notifyListeners();
  }

  final inputController = TextEditingController();

  clear() {
    inputController.clear();
  }

  paste() async {
    inputController.text = await ClipboardUtil.paste();
    convert();
  }

  copy() async {
    ClipboardUtil.copy(_base64Result);
  }

  convert() {
    if (_isEncode) {
      final result =
          const Base64Encoder().convert(inputController.text.codeUnits);
      base64Result = result;
    } else {
      try {
        Uint8List result = base64.decode(inputController.text);
        base64Result = String.fromCharCodes(result);
      } catch (e) {
        return;
      }
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}
