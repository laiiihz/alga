import 'package:flutter/material.dart';

@Deprecated('use ScrollableScaffold')
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
            automaticallyImplyLeading: false,
            leading: const BackButton(),
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
