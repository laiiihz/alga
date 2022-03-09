import 'package:alga/constants/import_helper.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final int? minLines;
  const AppTextField({
    Key? key,
    required this.controller,
    this.inputFormatters = const [],
    this.onChanged,
    this.maxLines,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: minLines,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}
