import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:alga/constants/import_helper.dart';
import 'package:tuple/tuple.dart';

import '../alga_view_provider.dart';

/// * item1: extended
/// * item2: labelType
typedef RailOption = Tuple2<bool, NavigationRailLabelType?>;

final _railOption =
    StateProvider.family<RailOption, AdaptiveWindowType>((ref, windowType) {
  int? index = ref.watch(rootIndex);
  bool extended = false;
  NavigationRailLabelType? labelType;

  if (windowType == AdaptiveWindowType.small) {
    labelType = NavigationRailLabelType.all;
  } else if (windowType == AdaptiveWindowType.medium) {
    extended = true;
  }
  if (index == 1) {
    extended = false;
    labelType = NavigationRailLabelType.none;
  }

  return RailOption(extended, labelType);
});

class AlgaRootRail extends ConsumerWidget {
  const AlgaRootRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowType = getBreakpointEntry(context).adaptiveWindowType;
    final railOption = ref.watch(_railOption(windowType));

    return NavigationRail(
      extended: railOption.item1,
      labelType: railOption.item2,
      leading: const SizedBox(height: 32),
      destinations: [
        NavigationRailDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: Text(context.tr.appName),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.category_outlined),
          selectedIcon: const Icon(Icons.category),
          label: Text(context.tr.allTools),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: Text(context.tr.settings),
        ),
      ],
      selectedIndex: ref.watch(rootIndex),
      onDestinationSelected: (index) {
        ref.watch(rootIndex.state).state = index;
        ref.watch(categoryIndex.state).state = null;
        ref.watch(toolIndex.state).state = null;
      },
    );
  }
}
