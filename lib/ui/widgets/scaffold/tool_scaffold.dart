import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/utils/extension/list_ext.dart';

class ToolScaffold extends StatelessWidget {
  const ToolScaffold({
    super.key,
    required this.title,
    this.actions,
    this.options,
    required this.body,
    this.padding = const EdgeInsets.all(16),
    this.fab,
    this.bottomNavigationBar,
  }) : isScroll = false;

  const ToolScaffold.scroll({
    super.key,
    required this.title,
    this.actions,
    this.options,
    required this.body,
    this.padding = const EdgeInsets.all(16),
    this.fab,
    this.bottomNavigationBar,
  }) : isScroll = true;

  final Widget title;
  final List<Widget>? actions;
  final List<Widget>? options;
  final Widget body;
  final bool isScroll;
  final EdgeInsetsGeometry padding;
  final Widget? fab;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    Widget content = body;
    Widget sliverAppBar = SliverAppBar.large(
      title: title,
      scrolledUnderElevation: 0,
      actions: actions,
    );

    if (options != null && options!.isNotEmpty) {
      if (isScroll) {
        content = CustomScrollView(
          slivers: [
            sliverAppBar,
            SliverPadding(
              padding: padding,
              sliver: SliverList.list(children: [
                ...options!.sep(const SizedBox(height: 4)),
                const SizedBox(height: 8),
                content,
              ]),
            ),
          ],
        );
      } else {
        content = Column(
          children: [
            ...options!.sep(const SizedBox(height: 4)),
            const SizedBox(height: 8),
            Expanded(child: content),
          ],
        );
        content = Padding(padding: padding, child: content);
      }
    } else {
      if (isScroll) {
        content = CustomScrollView(
          slivers: [
            sliverAppBar,
            SliverPadding(
              padding: padding,
              sliver: SliverToBoxAdapter(child: content),
            ),
          ],
        );
      } else {
        content = Padding(padding: padding, child: content);
      }
    }
    return Scaffold(
      appBar: isScroll
          ? null
          : AppBar(
              title: title,
              scrolledUnderElevation: 0,
              actions: actions,
            ),
      body: content,
      floatingActionButton: fab,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
