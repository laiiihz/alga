import 'package:alga/utils/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/solarized-dark.dart';
import 'package:highlight_textspan/highlight_textspan.dart';

class AppTextBox extends StatefulWidget {
  final String data;
  final String? lang;
  final int? minLines;
  final int? maxLines;
  final FocusScopeNode? focusNode;
  const AppTextBox(
      {Key? key,
      required this.data,
      this.lang,
      this.minLines,
      this.maxLines,
      this.focusNode})
      : super(key: key);

  @override
  State<AppTextBox> createState() => _AppTextBoxState();
}

class _AppTextBoxState extends State<AppTextBox> {
  late FocusScopeNode _focusNode;

  updateFocusState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusScopeNode();
    _focusNode.addListener(updateFocusState);
  }

  @override
  void dispose() {
    _focusNode.removeListener(updateFocusState);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFocus = _focusNode.hasFocus;

    Color getBorderColor() {
      if (isFocus) {
        return Theme.of(context).colorScheme.primary;
      } else {
        return isDark(context) ? Colors.white38 : Colors.black38;
      }
    }

    late Widget text;
    if (widget.lang == null) {
      text = SelectableText(
        widget.data,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
      );
    } else {
      text = SelectableText.rich(
        HighlightTextSpan(solarizedDarkTheme).span(
          widget.data,
          widget.lang!,
          Theme.of(context).textTheme.bodyText1,
        ),
        minLines: widget.minLines,
        maxLines: widget.maxLines,
      );
    }
    return FocusScope(
      node: _focusNode,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_focusNode);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: getBorderColor(),
              width: isFocus ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: text,
        ),
      ),
    );
  }
}
