import 'package:fluent_ui/fluent_ui.dart';

class ToolGroup extends PaneItemHeader {
  final List<ToolItem> items;
  ToolGroup({
    required Widget title,
    required this.items,
  }) : super(header: title);
}

class ToolItem extends PaneItem {
  final Widget page;
  ToolItem({
    required Widget icon,
    required Widget title,
    required this.page,
  }) : super(icon: icon, title: title);
}
