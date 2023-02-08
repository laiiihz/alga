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

class RichTextController extends TextEditingController {
  RichTextController({
    super.text,
    this.builder,
  });

  RichTextController.lang({super.text, required HighlightType type})
      : builder = LanguageBuilder.highlight(type);

  LanguageBuilder? builder;

  updateBuilder(LanguageBuilder b) {
    builder = b;
    notifyListeners();
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    if (builder == null) {
      return TextSpan(
        text: value.text,
        style: style,
      );
    } else {
      return TextSpan(
        style: style,
        children: <TextSpan>[
          builder!.build(context, value.text, style),
        ],
      );
    }
  }
}
