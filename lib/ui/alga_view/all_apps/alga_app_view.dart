import 'package:alga/models/app_atom.dart';
import 'package:alga/models/app_category.dart';
import 'package:alga/utils/constants/import_helper.dart';

import 'alga_app_item.dart';
import 'alga_app_view_provider.dart';

class AppsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AlgaAppView();
  }
}

class AlgaAppView extends StatefulWidget {
  const AlgaAppView({super.key});

  @override
  State<AlgaAppView> createState() => AlgaAppViewState();
}

class AlgaAppViewState extends State<AlgaAppView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
        centerTitle: false,
        bottom: const AppCategoriesPanel(),
      ),
      body: Consumer(builder: (context, ref, _) {
        return TabBarView(
          controller: ref.watch(appTabControllerProvider(vsync: this)),
          children: [AppCategory.allApps, ...AppCategory.items].map((e) {
            return AppCategoryView(e);
          }).toList(),
        );
      }),
    );
  }
}

class AppCategoriesPanel extends StatefulWidget implements PreferredSizeWidget {
  const AppCategoriesPanel({super.key});

  @override
  State<AppCategoriesPanel> createState() => _AppCategoriesPanelState();

  @override
  Size get preferredSize => const Size.fromHeight(46);
}

class _AppCategoriesPanelState extends State<AppCategoriesPanel> {
  @override
  Widget build(BuildContext context) {
    final parentState = context.findAncestorStateOfType<AlgaAppViewState>()!;
    return Consumer(
      builder: (context, ref, _) {
        return TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          controller: ref.watch(appTabControllerProvider(vsync: parentState)),
          indicatorPadding: const EdgeInsets.only(top: 44, left: 0, right: 0),
          tabs: [
            Tab(text: S.of(context).allApps),
            ...AppCategory.items.map((e) => Tab(text: e.name(context))),
          ],
        );
      },
    );
  }
}

class AppCategoryView extends StatelessWidget {
  const AppCategoryView(this.category, {super.key});

  final AppCategory category;

  List<AppAtom> get items => categoryMapping[category.uuid] ?? [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 2.0,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return AlgaAppItem(item);
      },
      itemCount: items.length,
    );
  }
}
