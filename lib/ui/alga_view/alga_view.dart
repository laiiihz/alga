import 'package:alga/ui/alga_view/widgets/alga_panel.dart';
import 'package:alga/ui/global.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlgaShellRouteView extends ConsumerWidget {
  const AlgaShellRouteView({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(isDesktopProvider)) {
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
      return Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: child,
      );
    }
  }
}
