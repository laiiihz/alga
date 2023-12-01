import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton(this.onRefresh, {super.key});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltip: context.tr.refresh,
      onPressed: onRefresh,
      icon: const Icon(Icons.refresh_rounded),
    );
  }
}
