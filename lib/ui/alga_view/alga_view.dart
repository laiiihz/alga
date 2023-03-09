import 'dart:io';

import 'package:alga/ui/alga_view/widgets/alga_navigation_bar.dart';
import 'package:alga/ui/alga_view/widgets/alga_panel.dart';
import 'package:alga/utils/constants/import_helper.dart';

class AlgaShellRouteView extends StatefulWidget {
  const AlgaShellRouteView({super.key, required this.child});
  final Widget child;

  @override
  State<AlgaShellRouteView> createState() => _AlgaShellRouteViewState();
}

class _AlgaShellRouteViewState extends State<AlgaShellRouteView> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      return Material(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AlgaPanel(),
            const VerticalDivider(width: 1),
            Expanded(
              child: Scaffold(
                body: ClipRect(child: widget.child),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: widget.child,
        bottomNavigationBar: const AlgaNavigationBar(),
      );
    }
  }
}
