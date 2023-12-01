import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/material.dart';

class CopyButton extends StatelessWidget {
  const CopyButton(this.onCopy, {super.key, this.icon});

  final String Function() onCopy;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltip: context.tr.copy,
      onPressed: () {
        ClipboardUtil.copy(onCopy());
      },
      icon: icon ?? const Icon(Icons.copy_rounded),
    );
  }
}
