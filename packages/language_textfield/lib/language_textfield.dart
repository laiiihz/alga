library language_textfield;

import 'package:flutter/material.dart';

export 'language_highlight_type.dart';

class LangTextField extends StatelessWidget {
  const LangTextField({
    Key? key,
    this.controller,
    this.maxLines,
    this.minLines,
    this.onChanged,
    required this.lang,
    this.expands = false,
    this.readOnly = false,
    this.inputDecoration = const InputDecoration(),
  }) : super(key: key);

  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final String lang;
  final bool expands;
  final InputDecoration inputDecoration;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      expands: expands,
      decoration: inputDecoration,
      textAlignVertical: TextAlignVertical.top,
      readOnly: readOnly,
    );
  }
}

class RichTextController extends TextEditingController {
  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    assert(!value.composing.isValid ||
        !withComposing ||
        value.isComposingRangeValid);
    // If the composing range is out of range for the current text, ignore it to
    // preserve the tree integrity, otherwise in release mode a RangeError will
    // be thrown and this EditableText will be built with a broken subtree.
    final bool composingRegionOutOfRange =
        !value.isComposingRangeValid || !withComposing;

    if (composingRegionOutOfRange) {
      return TextSpan(style: style, text: text);
    }

    final TextStyle composingStyle =
        style?.merge(const TextStyle(decoration: TextDecoration.underline)) ??
            const TextStyle(decoration: TextDecoration.underline);
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: value.composing.textBefore(value.text)),
        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(value.text),
        ),
        TextSpan(text: value.composing.textAfter(value.text)),
      ],
    );
  }
}
