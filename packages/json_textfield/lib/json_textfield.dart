library json_textfield;

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:json_textfield/json_special_builder.dart';

class JsonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final int maxLines;
  final int minLines;
  final ValueChanged<String>? onChanged;
  const JsonTextField({
    Key? key,
    this.controller,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExtendedTextField(
      controller: controller,
      specialTextSpanBuilder: JsonSpecialBuilder(),
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
    );
  }
}
