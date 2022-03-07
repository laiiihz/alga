library language_textfield;

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';

import 'lang_special_builder.dart';

class LangTextField extends StatelessWidget {
  final TextEditingController? controller;
  final int maxLines;
  final int minLines;
  final ValueChanged<String>? onChanged;
  final String lang;
  const LangTextField({
    Key? key,
    this.controller,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    required this.lang,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExtendedTextField(
      controller: controller,
      specialTextSpanBuilder: LangSpecialBuilder(lang),
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
    );
  }
}
