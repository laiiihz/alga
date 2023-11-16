import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/generators/lorem_ipsum_generator/lorem_ipsum_gen.dart';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lorem_ipsum_gen.provider.g.dart';

enum LoremIpsumType {
  words,
  sentences,
  paragraphs,
  ;

  String getName(BuildContext context) {
    switch (this) {
      case words:
        return context.tr.loremWords;
      case sentences:
        return context.tr.loremSentences;
      case paragraphs:
        return context.tr.loremParagraphs;
    }
  }

  String generate(int count) {
    return switch (this) {
      words => LoremIpsum.words(count).join(' '),
      sentences => LoremIpsum.sentences(count).join(' '),
      paragraphs => LoremIpsum.paragraphs(count).join('\n'),
    };
  }
}

@riverpod
class LoremType extends _$LoremType {
  @override
  LoremIpsumType build() => LoremIpsumType.words;

  void change(LoremIpsumType type) {
    state = type;
  }
}

@riverpod
String results(ResultsRef ref) {
  final type = ref.watch(loremTypeProvider);
  final count = ref.watch(useCount);
  return type.generate(count);
}
