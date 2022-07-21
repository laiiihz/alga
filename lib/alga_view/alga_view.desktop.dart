import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:alga/alga_view/widgets/alga_category_rail.dart';
import 'package:alga/alga_view/widgets/alga_root_rail.dart';
import 'package:alga/alga_view/widgets/alga_tool_rail.dart';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_category.dart';
import 'package:animations/animations.dart';

import 'alga_view_provider.dart';

class AlgaViewDesktop extends ConsumerWidget {
  const AlgaViewDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          const AlgaRootRail(),
          const VerticalDivider(width: 1),
          if (ref.watch(showCategory)) const AlgaCategoryRail(),
          if (ref.watch(showCategory)) const VerticalDivider(width: 1),
          if (ref.watch(showTools)) const AlgaToolRail(),
          if (ref.watch(showTools)) const VerticalDivider(width: 1),
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
              child: ref.watch(currentWidget),
            ),
          ),
        ],
      ),
    );
  }
}
