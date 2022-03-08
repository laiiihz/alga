import 'package:alga/extension/list_ext.dart';
import 'package:fluent_ui/fluent_ui.dart' as fui;
import 'package:flutter/material.dart';

class ToolView extends StatelessWidget {
  final Widget title;
  final Widget content;
  const ToolView({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  ToolView.scrollVertical({
    Key? key,
    EdgeInsets? padding = const EdgeInsets.all(12),
    required this.title,
    required List<Widget> children,
  })  : content = ListView(
          children: children.sep(const SizedBox(height: 8)),
          padding: padding,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = fui.FluentTheme.of(context).brightness == fui.Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: false,
      ),
      body: content,
      backgroundColor: isDark ? Colors.grey[900] : Colors.white70,
    );
  }
}
