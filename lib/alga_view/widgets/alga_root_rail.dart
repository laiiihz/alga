import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:alga/alga_view/widgets/tooltip_rail_item.dart';
import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/hotkey_util.dart';
import 'package:tuple/tuple.dart';

import '../alga_view_provider.desktop.dart';

/// * item1: extended
/// * item2: labelType
typedef RailOption = Tuple2<bool, NavigationRailLabelType?>;

class AlgaRootRail extends ConsumerWidget {
  const AlgaRootRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowType = getWindowType(context);
    return Column(
      children: [
        Expanded(
          child: NavigationRail(
            extended: false,
            labelType: NavigationRailLabelType.all,
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
              ref.read(rootIndex.notifier).update((state) => index);
              ref.read(categoryIndex.notifier).update((state) => null);
              ref.read(toolIndex.notifier).update((state) => null);
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
