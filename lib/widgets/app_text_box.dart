import 'package:alga/utils/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/solarized-dark.dart';
import 'package:highlight_textspan/highlight_textspan.dart';

class AppTextBox extends StatelessWidget {
  final String data;
  final String? lang;
  final int? minLines;
  final int? maxLines;
  const AppTextBox(
      {Key? key, required this.data, this.lang, this.minLines, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget text;
    if (lang == null) {
      text = SelectableText(
        data,
        minLines: minLines,
        maxLines: maxLines,
      );
    } else {
      text = SelectableText.rich(
        HighlightTextSpan(solarizedDarkTheme).span(
          data,
          lang!,
          Theme.of(context).textTheme.bodyText1,
        ),
        minLines: minLines,
        maxLines: maxLines,
      );
    }
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark(context) ? Colors.white38 : Colors.black38,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: text,
    );
  }
}
