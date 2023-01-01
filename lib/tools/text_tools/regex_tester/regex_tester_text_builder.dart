import 'package:flutter/material.dart';

import 'package:extended_text_field/extended_text_field.dart';

class RegexTesterTextBuilder extends SpecialTextSpanBuilder {
  RegexTesterTextBuilder(
    this.reg, {
    required this.primaryColor,
    required this.onPrimary,
  });
  final RegExp? reg;
  final Color primaryColor;
  final Color onPrimary;
  @override
  TextSpan build(String data,
      {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
    if (data.isEmpty) return const TextSpan(text: '');
    if (reg == null) return TextSpan(text: data, style: textStyle);

    String cacheData = data;
    final spans = <InlineSpan>[];

    RegExpMatch? currentMatch = reg!.firstMatch(cacheData);

    while (currentMatch != null) {
      spans.add(TextSpan(text: cacheData.substring(0, currentMatch.start)));
      spans.add(TextSpan(
        text: cacheData.substring(
          currentMatch.start,
          currentMatch.end,
        ),
        style: TextStyle(
          backgroundColor: primaryColor,
          color: onPrimary,
        ),
      ));
      if (currentMatch.end <= cacheData.length) {
        cacheData = cacheData.substring(currentMatch.end);
      }
      currentMatch = reg!.firstMatch(cacheData);
    }
    spans.add(TextSpan(text: cacheData));

    return TextSpan(children: spans, style: textStyle);
  }

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      required int index}) {
    return null;
  }
}
