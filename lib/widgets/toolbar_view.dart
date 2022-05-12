import 'package:alga/constants/import_helper.dart';
import 'package:alga/extension/list_ext.dart';

class ToolbarView extends StatelessWidget {
  final List<Widget> configs;
  final Widget inputWidget;
  final Widget outputWidget;
  final List<Widget> inputActions;
  final List<Widget> outputActions;
  final List<Widget> midWidgets;
  const ToolbarView({
    Key? key,
    required this.configs,
    required this.inputWidget,
    required this.outputWidget,
    this.inputActions = const [],
    this.outputActions = const [],
    this.midWidgets = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final input = Expanded(
      child: Column(
        children: [
          AppTitle(
            title: S.of(context).input,
            actions: inputActions.sep(const SizedBox(width: 4)),
          ),
          const SizedBox(height: 8),
          Expanded(child: inputWidget),
        ],
      ),
    );
    final output = Expanded(
      child: Column(
        children: [
          AppTitle(
            title: S.of(context).output,
            actions: outputActions.sep(const SizedBox(width: 4)),
          ),
          const SizedBox(height: 8),
          Expanded(child: outputWidget),
        ],
      ),
    );

    Widget result = const SizedBox.shrink();

    late Axis axis;
    if (isSmallDevice(context)) {
      axis = Axis.vertical;
    } else {
      axis = Axis.horizontal;
    }

    switch (axis) {
      case Axis.horizontal:
        result = Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            input,
            if (midWidgets.isNotEmpty) const SizedBox(width: 4),
            midWidgets.isEmpty
                ? const SizedBox(width: 8)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: midWidgets.sep(const SizedBox(width: 4)),
                  ),
            if (midWidgets.isNotEmpty) const SizedBox(width: 4),
            output,
          ],
        );
        break;
      case Axis.vertical:
        result = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            input,
            if (midWidgets.isNotEmpty) const SizedBox(height: 4),
            midWidgets.isEmpty
                ? const SizedBox(height: 8)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: midWidgets.sep(const SizedBox(width: 4)),
                  ),
            if (midWidgets.isNotEmpty) const SizedBox(height: 4),
            output,
          ],
        );
        break;
    }

    if (configs.isNotEmpty) {
      result = Column(
        children: [
          ToolViewWrapper(children: configs),
          Expanded(child: result),
        ],
      );
    }

    return Padding(padding: const EdgeInsets.all(12), child: result);
  }
}
