import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ToolbarPaste extends StatelessWidget {
  const ToolbarPaste({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltip: context.tr.paste,
      onPressed: () async {
        Clipboard.setData(ClipboardData(text: controller.text));
        // TODO(laiiihz): message
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(context.tr.pasted)));
      },
      icon: const Icon(Icons.paste_rounded),
    );
  }
}
