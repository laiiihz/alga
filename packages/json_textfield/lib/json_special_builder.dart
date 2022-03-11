import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/solarized-dark.dart';
import 'package:highlight_textspan/highlight_textspan.dart';

class JsonSpecialBuilder extends SpecialTextSpanBuilder {
  final Map<String, TextStyle> theme = solarizedDarkTheme;
  JsonSpecialBuilder();

  @override
  TextSpan build(String data,
      {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
    return HighlightTextSpan(theme).span(data, 'json', textStyle);
  }

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      required int index}) {
    return null;
  }
}
