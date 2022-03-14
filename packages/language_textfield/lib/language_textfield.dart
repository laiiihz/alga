library language_textfield;

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';

import 'lang_special_builder.dart';

export 'language_highlight_type.dart';

class LangTextField extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final String lang;
  final bool expands;
  final InputDecoration inputDecoration;
  const LangTextField({
    Key? key,
    this.controller,
    this.maxLines,
    this.minLines,
    this.onChanged,
    required this.lang,
    this.expands = false,
    this.inputDecoration = const InputDecoration(),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExtendedTextField(
      controller: controller,
      specialTextSpanBuilder: LangSpecialBuilder(lang),
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      expands: expands,
      decoration: inputDecoration,
      textAlignVertical: TextAlignVertical.top,
    );
  }
}
