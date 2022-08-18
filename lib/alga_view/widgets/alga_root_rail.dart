import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:alga/alga_view/widgets/tooltip_rail_item.dart';
import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/hotkey_util.dart';
import 'package:tuple/tuple.dart';

import '../alga_view_provider.desktop.dart';

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
  if (index == 0) {
    extended = false;
    labelType = NavigationRailLabelType.none;
  }

  return RailOption(extended, labelType);
});

class AlgaRootRail extends ConsumerWidget {
  const AlgaRootRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowType = getWindowType(context);
    final railOption = ref.watch(_railOption(windowType));
    return Column(
      children: [
        Expanded(
          child: NavigationRail(
            extended: railOption.item1,
            leading: const SizedBox(height: 32),
            destinations: [
              TooltipRailItem(
                icon: const Icon(Icons.category_rounded),
                text: context.tr.allTools,
                windowType: windowType,
              ),
              TooltipRailItem(
                icon: const Icon(Icons.settings_rounded),
                text: context.tr.settings,
                windowType: windowType,
              ),
            ],
            selectedIndex: ref.watch(rootIndex),
            onDestinationSelected: (index) {
              ref.watch(rootIndex.state).state = index;
              ref.watch(categoryIndex.state).state = null;
              ref.watch(toolIndex.state).state = null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Chip(
            labelStyle: const TextStyle(fontSize: 12),
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            label: Text('${context.tr.search} ${HotkeyUtil.label}'),
          ),
        ),
      ],
    );
  }
}
