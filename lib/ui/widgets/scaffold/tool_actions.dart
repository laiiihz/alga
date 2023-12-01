import 'package:flutter/material.dart';

class ToolActions extends StatelessWidget {
  const ToolActions({
    super.key,
    required this.actions,
    required this.child,
    this.childExpanded = false,
  });
  final List<Widget> actions;
  final Widget child;
  final bool childExpanded;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: actions,
        ),
        const SizedBox(height: 4),
        childExpanded ? Expanded(child: child) : child,
      ],
    );
  }
}
