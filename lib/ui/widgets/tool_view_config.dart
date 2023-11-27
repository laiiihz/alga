import 'package:flutter/material.dart';

class ToolViewConfig extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  const ToolViewConfig({
    super.key,
    required this.title,
    this.trailing,
    this.leading,
    this.subtitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      tileColor: scheme.onInverseSurface,
      onTap: onPressed,
    );
  }
}
