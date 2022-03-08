import 'package:alga/tools/generators/abstract/generator_base.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

enum LoremIpsumType {
  words,
  sentences,
  paragraphs,
}

extension LoremIpsumTypeExt on LoremIpsumType {
  String get value {
    switch (this) {
      case LoremIpsumType.words:
        return 'Words'.padRight(12);
      case LoremIpsumType.sentences:
        return 'Sentences'.padRight(12);
      case LoremIpsumType.paragraphs:
        return 'Paragraphs'.padRight(12);
    }
  }
}

class LoremIpsumProvider extends GeneratorBase {
  LoremIpsumType _type = LoremIpsumType.paragraphs;
  LoremIpsumType get type => _type;
  set type(LoremIpsumType state) {
    _type = state;
    notifyListeners();
  }

  int _count = 1;
  int get count => _count;
  set count(int state) {
    _count = state;
    notifyListeners();
  }

  TextEditingController outputController = TextEditingController();

  @override
  generate() {
    switch (_type) {
      case LoremIpsumType.words:
        outputController.text = LoremIpsum.words(_count).join(' ');
        return;
      case LoremIpsumType.sentences:
        outputController.text = LoremIpsum.sentences(_count).join(' ');
        return;
      case LoremIpsumType.paragraphs:
        outputController.text = LoremIpsum.paragraphs(_count).join(' ');
        return;
    }
  }

  copy() {
    ClipboardUtil.copy(outputController.text);
  }

  @override
  clear() {
    outputController.clear();
  }

  @override
  void dispose() {
    outputController.dispose();
    super.dispose();
  }
}
