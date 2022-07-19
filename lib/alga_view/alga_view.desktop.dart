import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/views/settings_view.dart';
import 'package:alga/widgets/placeholder_page.dart';
import 'package:animations/animations.dart';

final globalIndex =
    StateNotifierProvider<GlobalIndex, IndexState>((ref) => GlobalIndex());

class GlobalIndex extends StateNotifier<IndexState> {
  GlobalIndex() : super(IndexState.empty());

  go(int index, Widget? next) {
    bool reverse = index > state.index;
    state = state.copyWith(index: index, reverse: reverse, widget: next);
  }
}

class IndexState {
  const IndexState({
    required this.index,
    required this.reverse,
    required this.widget,
  });

  IndexState.empty()
      : index = 0,
        reverse = false,
        widget = const PlaceholderPage();

  final int index;
  final bool reverse;
  final Widget widget;

  IndexState copyWith({
    int? index,
    bool? reverse,
    Widget? widget,
  }) {
    return IndexState(
      index: index ?? this.index,
      reverse: reverse ?? this.reverse,
      widget: widget ?? const PlaceholderPage(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IndexState &&
        other.index == index &&
        other.reverse == reverse &&
        other.widget == widget;
  }

  @override
  int get hashCode => index.hashCode ^ reverse.hashCode ^ widget.hashCode;
}

class AlgaViewDesktop extends ConsumerWidget {
  const AlgaViewDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowType = getBreakpointEntry(context).adaptiveWindowType;
    bool extended = false;
    NavigationRailLabelType? labelType;
    switch (windowType) {
      case AdaptiveWindowType.xsmall:
        break;
      case AdaptiveWindowType.small:
        labelType = NavigationRailLabelType.all;
        break;
      case AdaptiveWindowType.medium:
        extended = true;
        break;
      case AdaptiveWindowType.large:
        break;
      case AdaptiveWindowType.xlarge:
        break;
      default:
        extended = false;
        break;
    }

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: extended,
            labelType: labelType,
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
            selectedIndex: ref.watch(globalIndex).index,
            onDestinationSelected: (index) {
              Widget? next;
              if (index == 2) next = const SettingsView();

              ref.watch(globalIndex.notifier).go(index, next);
            },
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: PageTransitionSwitcher(
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.scaled,
                  child: child,
                );
              },
              child: ref.watch(globalIndex).widget,
            ),
          ),
        ],
      ),
    );
  }
}
