import 'package:multi_split_view/multi_split_view.dart';

import '../../utils/constants/import_helper.dart';

@Deprecated('Scrollable Scaffold')
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    this.actions,
    required this.first,
    required this.second,
  });

  final Widget title;
  final List<Widget>? actions;
  final Widget first;
  final Widget second;

  @override
  Widget build(BuildContext context) {
    if (isSmallDevice(context)) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.medium(title: title, actions: actions),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(child: first),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(child: second),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: title, actions: actions),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: MultiSplitViewTheme(
            data: MultiSplitViewThemeData(
              dividerPainter: DividerPainters.grooved1(
                color: Theme.of(context).colorScheme.primary,
                highlightedColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: MultiSplitView(
              initialAreas: [Area(minimalSize: 200), Area(minimalSize: 200)],
              axis: Axis.horizontal,
              children: [first, second],
            ),
          ),
        ),
      );
    }
  }
}
