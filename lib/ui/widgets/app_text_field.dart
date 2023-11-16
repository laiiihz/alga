import 'package:flutter/material.dart';
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
  });

  final String? text;
  @Deprecated('use language')
  final String? lang;
  final HighlightType? language;
  final int? minLines;
  final int? maxLines;
  final bool expands;

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
    );
  }
}
