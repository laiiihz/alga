import 'package:devtoys/extension/list_ext.dart';
import 'package:devtoys/widgets/app_title.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../l10n/l10n.dart';

class ToolbarView extends StatelessWidget {
  final List<Widget> configs;
  final Widget inputWidget;
  final Widget outputWidget;
  final List<Widget> inputActions;
  final List<Widget> outputActions;
  final Axis axis;
  final List<Widget> midWidgets;
  const ToolbarView({
    Key? key,
    required this.configs,
    required this.inputWidget,
    required this.outputWidget,
    this.inputActions = const [],
    this.outputActions = const [],
    this.axis = Axis.horizontal,
    this.midWidgets = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _input = Expanded(
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
    final _output = Expanded(
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

    switch (axis) {
      case Axis.horizontal:
        result = Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _input,
            if (midWidgets.isNotEmpty) const SizedBox(width: 4),
            midWidgets.isEmpty
                ? const SizedBox(width: 8)
                : Column(
                    children: midWidgets.sep(const SizedBox(width: 4)),
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
            if (midWidgets.isNotEmpty) const SizedBox(width: 4),
            _output,
          ],
        );
        break;
      case Axis.vertical:
        result = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _input,
            if (midWidgets.isNotEmpty) const SizedBox(height: 4),
            midWidgets.isEmpty
                ? const SizedBox(height: 8)
                : Row(
                    children: midWidgets.sep(const SizedBox(width: 4)),
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
            if (midWidgets.isNotEmpty) const SizedBox(height: 4),
            _output,
          ],
        );
        break;
    }

    if (configs.isNotEmpty) {
      result = Column(
        children: [
          const AppTitle(title: 'Config'),
          const SizedBox(height: 8),
          ...configs.sep(const SizedBox(height: 4)),
          const SizedBox(height: 8),
          Expanded(child: result),
        ],
      );
    }

    return result;
  }
}
