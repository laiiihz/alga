import 'package:alga/utils/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:language_textfield/lang_special_builder.dart';
import 'package:language_textfield/language_textfield.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.text,
    this.lang,
    this.language,
    this.minLines,
    this.maxLines,
    this.expands = false,
    this.decoration = const InputDecoration(),
  });

  final String? text;
  @Deprecated('use language')
  final String? lang;
  final HighlightType? language;
  final int? minLines;
  final int? maxLines;
  final bool expands;
  final InputDecoration? decoration;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    if (widget.language == null) {
      _controller = TextEditingController(text: widget.text);
    } else {
      _controller =
          RichTextController.lang(type: widget.language!, text: widget.text);
    }
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    _controller.text = widget.text ?? '';
    if (_controller is RichTextController && widget.language != null) {
      (_controller as RichTextController)
          .updateBuilder(LanguageBuilder.highlight(widget.language!));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: _controller,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      expands: widget.expands,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      decoration: widget.decoration,
      style: getMonoTextStyle(context),
    );
  }
}

class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    required this.controller,
    this.minLines,
    this.maxLines = 1,
    this.decoration = const InputDecoration(),
    this.expands = false,
    this.textAlignVertical = TextAlignVertical.top,
    this.onChanged,
  });
  final TextEditingController controller;
  final int? minLines;
  final int? maxLines;
  final bool expands;
  final InputDecoration? decoration;
  final TextAlignVertical textAlignVertical;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      style: getMonoTextStyle(context),
      textAlignVertical: textAlignVertical,
      decoration: decoration,
      onChanged: onChanged,
      expands: expands,
    );
  }
}
