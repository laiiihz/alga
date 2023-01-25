library language_textfield;

import 'package:flutter/material.dart';
import 'package:language_textfield/lang_special_builder.dart';

import 'language_highlight_type.dart';

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

class LanguageTextField extends StatelessWidget {
  const LanguageTextField({
    Key? key,
    this.controller,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.expands = false,
    this.readOnly = false,
    this.inputDecoration = const InputDecoration(),
  }) : super(key: key);

  final RichTextController? controller;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
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
  RichTextController({
    super.text,
    required this.builder,
  });

  RichTextController.lang({super.text, required HighlightType type})
      : builder = LanguageBuilder.highlight(type);

  final LanguageBuilder builder;

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    return TextSpan(
      style: style,
      children: <TextSpan>[
        builder.build(context, value.text, style),
      ],
    );
  }
}
