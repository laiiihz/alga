import 'package:alga/ui/alga_view/widgets/alga_navigation_bar.dart';
import 'package:alga/ui/alga_view/widgets/alga_panel.dart';
import 'package:alga/ui/global.provider.dart';
import 'package:alga/utils/constants/import_helper.dart';

class AlgaShellRouteView extends ConsumerWidget {
  const AlgaShellRouteView({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(isDesktop)) {
      return Material(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AlgaPanel(),
            const VerticalDivider(width: 1),
            Expanded(
              child: Scaffold(
                body: ClipRect(child: child),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: child,
        bottomNavigationBar: const AlgaNavigationBar(),
      );
    }
  }
}
