// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/utils/extension/list_ext.dart';

///
///  --- AppBar ---
///
/// --- configurations ---
///
/// --- children ---
///
/// --- child ---
///
/// --- slivers ---
///
/// --- fillRemain ---
class ScrollableScaffold extends StatelessWidget {
  const ScrollableScaffold({
    super.key,
    required this.title,
    this.configurations = const [],
    this.children = const [],
    this.actions = const [],
    this.slivers = const [],
    this.fillRemain,
    this.hasScrollBody = false,
    this.child,
  });

  final Widget title;
  final List<Widget> configurations;
  final List<Widget> children;
  final List<Widget> actions;
  final List<Widget> slivers;
  final Widget? child;
  final Widget? fillRemain;
  final bool hasScrollBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverAppBar.medium(title: title, actions: actions),
          if (configurations.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              sliver: SliverList.list(
                children: configurations.sep(const SizedBox(height: 4)),
              ),
            ),
          if (children.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              sliver: SliverList.list(
                children: children.sep(const SizedBox(height: 4)),
              ),
            ),
          if (child != null)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              sliver: SliverToBoxAdapter(child: child),
            ),
          ...slivers,
          if (fillRemain != null)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              sliver: SliverFillRemaining(
                hasScrollBody: hasScrollBody,
                child: fillRemain,
              ),
            ),
        ],
      ),
    );
  }
}
