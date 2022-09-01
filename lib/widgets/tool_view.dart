import 'package:flutter/material.dart';

class ToolView extends StatelessWidget {
  final Widget title;
  final Widget content;
  const ToolView({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: false,
      ),
      body: content,
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}

class ScrollableToolView extends StatelessWidget {
  const ScrollableToolView({
    super.key,
    this.padding = const EdgeInsets.all(12),
    required this.title,
    required this.children,
  });

  final EdgeInsets padding;
  final Widget title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: title,
          ),
          SliverPadding(
            padding: padding,
            sliver: SliverList(delegate: SliverChildListDelegate(children)),
          ),
        ],
      ),
    );
  }
}
