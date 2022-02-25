import 'package:flutter/services.dart';

class ClipboardUtil {
  static Future<void> copy(String data) async {
    await Clipboard.setData(ClipboardData(text: data));
  }

  static Future<String> paste() async {
    final result = await Clipboard.getData('text/plain');
    return result?.text ?? '';
  }
}
