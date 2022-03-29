import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import 'package:alga/l10n/l10n.dart';

enum LoremIpsumType {
  words,
  sentences,
  paragraphs,
}

extension LoremIpsumTypeExt on LoremIpsumType {
  String typeName(BuildContext context) {
    switch (this) {
      case LoremIpsumType.words:
        return S.of(context).loremWords;
      case LoremIpsumType.sentences:
        return S.of(context).loremSentences;
      case LoremIpsumType.paragraphs:
        return S.of(context).loremParagraphs;
    }
  }
}

class LoremState {
  final String output;
  LoremState({required this.output});
}

final loremType = StateProvider.autoDispose<LoremIpsumType>((ref) {
  return LoremIpsumType.paragraphs;
});
final loremCount = StateProvider.autoDispose<int>((ref) => 1);
final loremNumberController = StateProvider.autoDispose((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final loremProvider = FutureProvider.autoDispose<LoremState>((ref) {
  final count = ref.watch(loremCount);
  final type = ref.watch(loremType);
  switch (type) {
    case LoremIpsumType.words:
      return LoremState(output: LoremIpsum.words(count).join(' '));
    case LoremIpsumType.sentences:
      return LoremState(output: LoremIpsum.sentences(count).join(' '));
    case LoremIpsumType.paragraphs:
      return LoremState(output: LoremIpsum.paragraphs(count).join(' '));
  }
});
