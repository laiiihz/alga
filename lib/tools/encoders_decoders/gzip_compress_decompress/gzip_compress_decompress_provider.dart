import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/material.dart';

class GzipCompressDecompressProvider extends ChangeNotifier {
  bool _isCompress = true;
  bool get isCompress => _isCompress;
  set isCompress(bool state) {
    _isCompress = state;
    notifyListeners();
  }

  String _gzipResult = '';
  String get gzipResult => _gzipResult;
  set gzipResult(String state) {
    _gzipResult = state;
    notifyListeners();
  }

  final inputController = TextEditingController();

  paste() async {
    inputController.text = await ClipboardUtil.paste();
  }

  copy() {
    ClipboardUtil.copy(_gzipResult);
  }

  clear() {
    inputController.clear();
  }

  convert() {
    try {
      if (_isCompress) {
        final encoder = GZipEncoder();
        const base64Encoder = Base64Encoder();
        final result = encoder.encode(inputController.text.codeUnits);
        if (result == null) return;
        gzipResult = base64Encoder.convert(result);
      } else {
        final decoder = GZipDecoder();
        const base64Decoder = Base64Decoder();
        Uint8List result = base64Decoder.convert(inputController.text);
        gzipResult = String.fromCharCodes(decoder.decodeBytes(result));
      }
    } catch (e) {
      return;
    }
  }

  swapData() {
    String temp = inputController.text;
    inputController.text = gzipResult;
    gzipResult = temp;
  }

  @override
  void dispose() {
    inputController.dispose();

    super.dispose();
  }
}
