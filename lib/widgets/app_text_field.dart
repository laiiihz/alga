import 'package:alga/constants/import_helper.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final int? minLines;
  final String? hintText;
  final Widget? prefixIcon;
  final bool autofocus;
  const AppTextField({
    Key? key,
    required this.controller,
    this.inputFormatters = const [],
    this.onChanged,
    this.maxLines,
    this.minLines,
    this.hintText,
    this.prefixIcon,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      controller: controller,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
