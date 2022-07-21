import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_category.dart';

import '../alga_view_provider.dart';

class AlgaCategoryRail extends ConsumerWidget {
  const AlgaCategoryRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationRail(
      extended: !ref.watch(enterTool),
      destinations: ToolCategories.items.map((e) {
        return NavigationRailDestination(
          icon: e.icon,
          label: Text(e.name(context)),
        );
      }).toList(),
      selectedIndex: ref.watch(categoryIndex),
      onDestinationSelected: (index) {
        ref.watch(categoryIndex.state).state = index;
        ref.watch(toolIndex.state).state = null;
      },
    );
  }
}
