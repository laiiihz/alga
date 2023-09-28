import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/solarized-dark.dart';
import 'package:flutter_highlight/themes/solarized-light.dart';
import 'package:highlight_textspan/highlight_textspan.dart';

import 'language_highlight_type.dart';

abstract class LanguageBuilder {
  TextSpan build(BuildContext context, String text, TextStyle? style);

  static LanguageBuilder highlight(HighlightType type) =>
      _HighlightBuilder(type);

  static LanguageBuilder custom(
          TextSpan Function(
            BuildContext context,
            String text,
            TextStyle? style,
          ) value) =>
      _CustomBuilder(value);

  static final LanguageBuilder regex = _RegexBuilder();
  static final LanguageBuilder jwt = _JwtBuilder();
}

class _HighlightBuilder extends LanguageBuilder {
  _HighlightBuilder(this.type);

  final HighlightType type;

  @override
  TextSpan build(BuildContext context, String text, TextStyle? style) {
    final theme = Theme.of(context).brightness == Brightness.dark
        ? solarizedDarkTheme
        : solarizedLightTheme;
    return HighlightTextSpan(theme).span(text, type.name, style);
  }
}

class _CustomBuilder extends LanguageBuilder {
  _CustomBuilder(this.value);

  final TextSpan Function(BuildContext context, String text, TextStyle? style)
      value;
  @override
  TextSpan build(BuildContext context, String text, TextStyle? style) {
    return value(context, text, style);
  }
}

class _RegexBuilder extends LanguageBuilder {
  _RegexBuilder();
  @override
  TextSpan build(BuildContext context, String text, TextStyle? style) {
    if (text.isEmpty) return const TextSpan();

    final spans = <TextSpan>[];
    int currentIndex = 0;

    void colorSpan(Color color) {
      spans.add(TextSpan(
        text: text[currentIndex],
        style: TextStyle(color: color),
      ));
    }

    while ((currentIndex + 1) <= text.length) {
      final current = text[currentIndex];

      if (current == '[' || current == ']') {
        colorSpan(Colors.red);
      } else if (current == '{' || current == '}') {
        colorSpan(Colors.green);
      } else if (current == '(' || current == ')') {
        colorSpan(Colors.blue);
      } else {
        spans.add(TextSpan(text: text[currentIndex]));
      }

      currentIndex++;
    }

    return TextSpan(children: spans);
  }
}

class _JwtBuilder extends LanguageBuilder {
  @override
  TextSpan build(BuildContext context, String text, TextStyle? style) {
    if (text.isEmpty) return const TextSpan();
    final items = text.split('.');
    if (items.length != 3) return TextSpan(text: text);
    final resultSpans = <TextSpan>[];
    resultSpans.add(
      TextSpan(text: items[0], style: const TextStyle(color: Colors.red)),
    );
    resultSpans.add(const TextSpan(text: '.'));
    resultSpans.add(
      TextSpan(text: items[1], style: const TextStyle(color: Colors.purple)),
    );
    resultSpans.add(const TextSpan(text: '.'));
    resultSpans.add(
      TextSpan(text: items[2], style: const TextStyle(color: Colors.blue)),
    );
    return TextSpan(children: resultSpans);
  }
}
