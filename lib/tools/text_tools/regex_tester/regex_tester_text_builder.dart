import 'package:flutter/material.dart';
import 'package:language_textfield/lang_special_builder.dart';

class RegexTesterBuilder extends LanguageBuilder {
  RegexTesterBuilder(this.regex);
  final RegExp? regex;
  @override
  TextSpan build(BuildContext context, String text, TextStyle? style) {
    if (regex == null || text.isEmpty) {
      return TextSpan(text: text, style: style);
    }
    final primary = Theme.of(context).colorScheme.primary;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    final spans = <InlineSpan>[];

    int currentIndex = 0;
    Match? currentMatch = regex!.matchAsPrefix(text, currentIndex);
    while (currentIndex < text.length) {
      if (currentMatch != null) {
        if (currentMatch.start == currentMatch.end) {
          currentIndex++;
        } else {
          final tempText = text.substring(
            currentMatch.start,
            currentMatch.end,
          );
          spans.add(TextSpan(
            text: tempText,
            style: TextStyle(color: onPrimary, backgroundColor: primary),
          ));
          currentIndex += currentMatch.end - currentMatch.start;
        }
      } else {
        spans.add(TextSpan(text: text[currentIndex]));
        currentIndex++;
      }
      currentMatch = regex!.matchAsPrefix(text, currentIndex);
    }
    spans.add(TextSpan(text: text.substring(currentIndex)));

    return TextSpan(children: spans, style: style);
  }
}
