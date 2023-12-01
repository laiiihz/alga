import 'package:alga/l10n/l10n.dart';
import 'package:flutter/material.dart';

class AlgaToolbar extends StatelessWidget {
  const AlgaToolbar({
    super.key,
    this.title,
    this.actions = const [],
  });
  final Widget? title;
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          child: title ?? Text(context.tr.output),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            alignment: WrapAlignment.end,
            children: actions,
          ),
        ),
      ],
    );
  }
}
