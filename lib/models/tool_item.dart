import 'package:fluent_ui/fluent_ui.dart';

class ToolGroup extends PaneItemHeader {
  final List<ToolItem> items;
  ToolGroup({
    required Text title,
    required this.items,
  }) : super(header: title);
}

class ToolItem extends PaneItem {
  final Widget page;

  String get text => (title as Text).data ?? '';

  ToolItem({
    required Widget icon,
    required Text title,
    required this.page,
  }) : super(icon: icon, title: title);
}
