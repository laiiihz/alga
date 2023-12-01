import 'package:alga/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ToolCopy extends StatelessWidget {
  const ToolCopy(this.controller, {super.key}) : onlyIcon = false;
  const ToolCopy.icon(this.controller, {super.key}) : onlyIcon = true;

  final bool onlyIcon;
  final TextEditingController controller;

  void onCopy() {}

  @override
  Widget build(BuildContext context) {
    if (onlyIcon) {
      return IconButton(
        onPressed: onCopy,
        icon: const Icon(Icons.copy_rounded),
      );
    } else {
      return FilledButton.tonalIcon(
        onPressed: onCopy,
        icon: const Icon(Icons.copy_rounded),
        label: Text(context.tr.copy),
      );
    }
  }
}
