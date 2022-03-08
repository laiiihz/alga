import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/material.dart';

class RegexTesterProvider extends ChangeNotifier {
  final regexController = TextEditingController();
  final textController = TextEditingController();

  RegExp? get reg {
    if (regexController.text.isEmpty) return null;
    try {
      return RegExp(regexController.text);
    } catch (e) {
      return null;
    }
  }

  pasteReg() async {
    regexController.text = await ClipboardUtil.paste();
  }

  pasteText() async {
    textController.text = await ClipboardUtil.paste();
  }

  clearReg() {
    regexController.clear();
  }

  clearText() {
    textController.clear();
  }

  update() {
    notifyListeners();
  }

  @override
  void dispose() {
    regexController.dispose();
    textController.dispose();
    super.dispose();
  }
}
