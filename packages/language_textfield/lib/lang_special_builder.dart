// import 'package:flutter/material.dart';
// import 'package:flutter_highlight/themes/solarized-dark.dart';
// import 'package:highlight_textspan/highlight_textspan.dart';

// class LangSpecialBuilder extends SpecialTextSpanBuilder {
//   final String lang;

//   LangSpecialBuilder(this.lang);

//   Map<String, TextStyle> get theme => solarizedDarkTheme;

//   @override
//   TextSpan build(String data,
//       {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
//     return HighlightTextSpan(theme).span(data, lang, textStyle);
//   }

//   @override
//   SpecialText? createSpecialText(String flag,
//       {TextStyle? textStyle,
//       SpecialTextGestureTapCallback? onTap,
//       required int index}) {
//     return null;
//   }
// }

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
  )
              value) =>
      _CustomBuilder(value);
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
