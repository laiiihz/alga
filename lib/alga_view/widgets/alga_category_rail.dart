import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_category.dart';

import '../alga_view_provider.desktop.dart';
import 'tooltip_rail_item.dart';

class AlgaCategoryRail extends ConsumerWidget {
  const AlgaCategoryRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowType = getWindowType(context);
    return MouseRegion(
      onEnter: (_) {
        ref.watch(enterCategory.state).state = true;
      },
      onExit: (_) {
        ref.watch(enterCategory.state).state = false;
      },
      child: NavigationRail(
        extended: ref.watch(computedCategoryExpand(windowType)),
        destinations: ToolCategories.items.map((e) {
          return TooltipRailItem(
            icon: e.icon,
            text: e.name(context),
            windowType: windowType,
          );
        }).toList(),
        selectedIndex: ref.watch(categoryIndex),
        onDestinationSelected: (index) {
          ref.watch(categoryIndex.state).state = index;
          ref.watch(toolIndex.state).state = null;
        },
      ),
    );
  }
}
