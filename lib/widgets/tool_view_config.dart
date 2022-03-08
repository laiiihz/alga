import 'package:flutter/material.dart';

class ToolViewConfig extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget trailing;
  final VoidCallback? onPressed;
  const ToolViewConfig(
      {Key? key,
      required this.title,
      required this.trailing,
      this.leading,
      this.subtitle,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        tileColor: isDark ? Colors.grey[900] : Colors.grey[50],
      ),
    );
  }
}
