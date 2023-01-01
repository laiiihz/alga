import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/app_atom.dart';
import 'package:alga/models/app_category.dart';

import 'alga_app_item.dart';

class AlgaAppView extends StatefulWidget {
  const AlgaAppView({super.key});

  @override
  State<AlgaAppView> createState() => AlgaAppViewState();
}

class AlgaAppViewState extends State<AlgaAppView>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: AppCategory.items.length + 1,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).allApps),
        bottom: const AppCategoriesPanel(),
      ),
      body: TabBarView(
        controller: tabController,
        children: [AppCategory.allApps, ...AppCategory.items].map((e) {
          return AppCategoryView(e);
        }).toList(),
      ),
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
    return TabBar(
      isScrollable: true,
      controller: parentState.tabController,
      tabs: [
        Tab(text: S.of(context).allApps),
        ...AppCategory.items.map(
          (e) => Tab(
            text: e.name(context),
          ),
        ),
      ],
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
        maxCrossAxisExtent: 240,
        childAspectRatio: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return AlgaAppItem(item);
      },
      itemCount: items.length,
    );
  }
}
