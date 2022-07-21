import 'package:alga/alga_view/alga_view_provider.dart';
import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_atoms.dart';
import 'package:alga/models/tool_category.dart';

class AlgaToolRail extends ConsumerWidget {
  const AlgaToolRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int? categoryIndex_ = ref.watch(categoryIndex);
    if (categoryIndex_ == null) return const SizedBox.shrink();
    final current = ToolCategories.items[categoryIndex_];
    final toolItems = getByCategory(current);
    if (toolItems.length < 2) return const Placeholder();
    return MouseRegion(
      onEnter: (_) {
        ref.watch(enterTool.state).state = true;
      },
      onExit: (_) {
        ref.watch(enterTool.state).state = false;
      },
      child: NavigationRail(
        extended: ref.watch(enterTool),
        destinations: toolItems.map((e) {
          return NavigationRailDestination(
            icon: e.icon,
            label: Text(e.name(context)),
          );
        }).toList(),
        selectedIndex: ref.watch(toolIndex),
        onDestinationSelected: (index) {
          ref.watch(toolIndex.state).state = index;
        },
      ),
    );
  }
}
