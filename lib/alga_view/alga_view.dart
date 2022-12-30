import 'package:alga/alga_view/widgets/alga_panel.dart';
import 'package:alga/constants/import_helper.dart';

class AlgaShellRouteView extends StatefulWidget {
  const AlgaShellRouteView({super.key, required this.child});
  final Widget child;

  @override
  State<AlgaShellRouteView> createState() => _AlgaShellRouteViewState();
}

class _AlgaShellRouteViewState extends State<AlgaShellRouteView> {
  @override
  void didUpdateWidget(covariant AlgaShellRouteView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AlgaPanel(),
          const VerticalDivider(width: 1),
          Expanded(
            child: Scaffold(
                body: ClipRect(
              child: widget.child,
            )),
          ),
        ],
      ),
    );
  }
}
