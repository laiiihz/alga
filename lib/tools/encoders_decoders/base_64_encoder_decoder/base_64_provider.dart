import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum EncodeDecodeType {
  encode,
  decode,
}

extension EncodeDecodeTypeExt on EncodeDecodeType {
  String get value {
    switch (this) {
      case EncodeDecodeType.encode:
        return 'encode'.padRight(8);
      case EncodeDecodeType.decode:
        return 'decode'.padRight(8);
    }
  }
}

class Base64Provider extends ChangeNotifier {
  EncodeDecodeType _type = EncodeDecodeType.encode;
  EncodeDecodeType get type => _type;

  final inputController = TextEditingController();
  final outputController = TextEditingController();

  set type(EncodeDecodeType state) {
    _type = state;
    notifyListeners();
  }

  clearAll() {
    inputController.clear();
    outputController.clear();
  }

  paste() async {
    final clipRes = await Clipboard.getData('text/plain');
    inputController.text = clipRes?.text ?? '';
  }

  copy() async {
    Clipboard.setData(ClipboardData(text: outputController.text));
  }

  convert() {
    switch (_type) {
      case EncodeDecodeType.encode:
        final result =
            const Base64Encoder().convert(inputController.text.codeUnits);
        outputController.text = result;
        break;
      case EncodeDecodeType.decode:
        try {
          Uint8List result = base64.decode(inputController.text);
          outputController.text = String.fromCharCodes(result);
        } catch (e) {
          print(e);
        }
        break;
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }
}
