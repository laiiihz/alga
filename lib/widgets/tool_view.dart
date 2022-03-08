import 'package:alga/extension/list_ext.dart';
import 'package:flutter/material.dart';

class ToolView extends StatelessWidget {
  final Widget title;
  final Widget content;
  const ToolView({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  static scrollVertical({
    Key? key,
    EdgeInsets? padding = const EdgeInsets.all(12),
    required Widget title,
    required List<Widget> children,
  }) {
    return _ToolViewScrollable(
      key: key,
      padding: padding,
      title: title,
      children: children.sep(const SizedBox(height: 8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
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

class _ToolViewScrollable extends StatefulWidget {
  final EdgeInsets? padding;
  final Widget title;
  final List<Widget> children;
  const _ToolViewScrollable({
    Key? key,
    this.padding = const EdgeInsets.all(12),
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  State<_ToolViewScrollable> createState() => __ToolViewScrollableState();
}

class __ToolViewScrollableState extends State<_ToolViewScrollable> {
  final _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView(
      title: widget.title,
      content: ListView(
        controller: _scrollController,
        padding: widget.padding,
        children: widget.children,
      ),
    );
  }
}
