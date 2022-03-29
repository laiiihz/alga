import 'package:flutter/material.dart';

import 'package:extended_text_field/extended_text_field.dart';

class JWTSpecialTextBuilder extends SpecialTextSpanBuilder {
  @override
  TextSpan build(String data,
      {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
    final items = data.split('.');

    if (items.length != 3) {
      return TextSpan(
        text: data,
        style: textStyle,
      );
    }

    final spans = <TextSpan>[];
    spans.add(TextSpan(
      text: items[0],
      style: const TextStyle(color: Colors.red),
    ));
    spans.add(const TextSpan(text: '.'));
    spans.add(TextSpan(
      text: items[1],
      style: const TextStyle(color: Colors.purple),
    ));
    spans.add(const TextSpan(text: '.'));
    spans.add(TextSpan(
      text: items[2],
      style: const TextStyle(color: Colors.blue),
    ));
    return TextSpan(
      style: textStyle,
      children: spans,
    );
  }

  @override
  SpecialText? createSpecialText(String flag,
          {TextStyle? textStyle,
          SpecialTextGestureTapCallback? onTap,
          required int index}) =>
      null;
}
