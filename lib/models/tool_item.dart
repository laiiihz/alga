import 'package:flutter/material.dart';

class ToolGroup {
  final List<ToolItem> items;
  final Text title;
  final Widget icon;
  ToolGroup({
    required this.title,
    required this.items,
    required this.icon,
  });
}

class ToolItem {
  final Widget page;
  final Text Function(BuildContext context) title;
  final Widget icon;

  String text(BuildContext context) => title(context).data ?? '';

  ToolItem({
    required this.icon,
    required this.title,
    required this.page,
  });
}
