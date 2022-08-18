import 'package:flutter/material.dart';
import 'package:language_textfield/language_textfield.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.text,
    this.lang,
    this.minLines,
    this.maxLines,
  });

  final String text;
  final String? lang;
  final int? minLines;
  final int? maxLines;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    _controller.text = widget.text;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lang != null) {
      return LangTextField(
        lang: widget.lang!,
        controller: _controller,
        readOnly: true,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
      );
    }
    return TextField(
      readOnly: true,
      controller: _controller,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
    );
  }
}
