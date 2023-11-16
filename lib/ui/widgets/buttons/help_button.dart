import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({
    super.key,
    this.tooltip,
    required this.onPressed,
  });

  final String? tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltip: tooltip ?? context.tr.help,
      onPressed: () {
        onPressed();
      },
      icon: const Icon(Icons.help_outline_rounded),
    );
  }
}
