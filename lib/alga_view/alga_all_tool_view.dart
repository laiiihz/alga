import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_atoms.dart';
import 'package:animations/animations.dart';

import '../models/tool_category.dart';

final useGrid = StateProvider.autoDispose<bool>((ref) => false);

class AlgaAllToolView extends ConsumerWidget {
  const AlgaAllToolView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.allTools),
        actions: [
          IconButton(
            onPressed: () {
              ref.watch(useGrid.state).state = !ref.watch(useGrid);
            },
            icon: ref.watch(useGrid)
                ? const Icon(Icons.grid_3x3)
                : const Icon(Icons.list_rounded),
          ),
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        child: ref.watch(useGrid) ? const _GridItems() : const _ListItems(),
      ),
    );
  }
}

class _ListItems extends StatelessWidget {
  const _ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = ToolCategories.items[index];
        return ExpansionTile(
          leading: item.icon,
          title: Text(item.name(context)),
          children: getByCategory(item).map((e) {
            return ListTile(
              leading: e.icon,
              title: Text(e.name(context)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => e.widget),
                );
              },
            );
          }).toList(),
        );
      },
      itemCount: ToolCategories.items.length,
    );
  }
}

class _GridItems extends StatelessWidget {
  const _GridItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 160,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final item = toolAtoms[index];
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: Theme.of(context).textTheme.button,
          ),
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              item.icon,
              const SizedBox(height: 8),
              Text(
                item.name(context),
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
      itemCount: toolAtoms.length,
    );
  }
}
