import 'package:alga/alga_view/alga_view_provider.mobile.dart';
import 'package:alga/constants/import_helper.dart';
import 'package:animations/animations.dart';

class AlgaViewMobile extends ConsumerWidget {
  const AlgaViewMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        child: ref.watch(currentWidget),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: ref.watch(rootIndex),
        onDestinationSelected: (index) {
          ref.watch(rootIndex.state).state = index;
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_rounded),
            label: context.tr.appName,
          ),
          NavigationDestination(
            icon: const Icon(Icons.category_rounded),
            label: context.tr.allTools,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_rounded),
            label: context.tr.settings,
          ),
        ],
      ),
    );
  }
}
