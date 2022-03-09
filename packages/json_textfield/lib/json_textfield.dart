library json_textfield;

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:json_textfield/json_special_builder.dart';

class JsonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final InputDecoration? inputDecoration;
  final bool expands;
  const JsonTextField({
    Key? key,
    this.controller,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.inputDecoration,
    this.expands = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExtendedTextField(
      controller: controller,
      specialTextSpanBuilder: JsonSpecialBuilder(),
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      expands: expands,
      decoration: inputDecoration,
    );
  }
}
