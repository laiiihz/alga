import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:devtoys/constants/import_helper.dart';
import 'package:devtoys/utils/clipboard_util.dart';

class GzipCompressDecompressProvider extends ChangeNotifier {
  bool _isCompress = true;
  bool get isCompress => _isCompress;
  set isCompress(bool state) {
    _isCompress = state;
    notifyListeners();
  }

  final inputController = TextEditingController();
  final outputController = TextEditingController();

  paste() async {
    inputController.text = await ClipboardUtil.paste();
  }

  copy() {
    ClipboardUtil.copy(outputController.text);
  }

  clear() {
    inputController.clear();
    outputController.clear();
  }

  convert() {
    try {
      if (_isCompress) {
        final encoder = GZipEncoder();
        const base64Encoder = Base64Encoder();
        final result = encoder.encode(inputController.text.codeUnits);
        if (result == null) return;
        outputController.text = base64Encoder.convert(result);
      } else {
        final decoder = GZipDecoder();
        const base64Decoder = Base64Decoder();
        Uint8List result = base64Decoder.convert(inputController.text);
        outputController.text =
            String.fromCharCodes(decoder.decodeBytes(result));
      }
    } catch (e) {
      return;
    }
  }

  swapData() {
    String temp = inputController.text;
    inputController.text = outputController.text;
    outputController.text = temp;
  }

  @override
  void dispose() {
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }
}
