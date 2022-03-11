import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/solarized-dark.dart';
import 'package:highlight_textspan/highlight_textspan.dart';

class LangSpecialBuilder extends SpecialTextSpanBuilder {
  final String lang;

  LangSpecialBuilder(this.lang);

  Map<String, TextStyle> get theme => solarizedDarkTheme;

  @override
  TextSpan build(String data,
      {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
    return HighlightTextSpan(theme).span(data, lang, textStyle);
  }

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      required int index}) {
    return null;
  }
}
