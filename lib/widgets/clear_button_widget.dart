import 'package:alga/constants/import_helper.dart';

import 'custom_icon_button.dart';

class ClearButtonWidget extends StatefulWidget {
  const ClearButtonWidget(this.controller, {super.key});
  final TextEditingController controller;

  @override
  State<ClearButtonWidget> createState() => _ClearButtonWidgetState();
}

class _ClearButtonWidgetState extends State<ClearButtonWidget> {
  late bool _enabled;

  updateState() {
    _enabled = widget.controller.text.isNotEmpty;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    updateState();
    widget.controller.addListener(updateState);
  }

  @override
  void dispose() {
    widget.controller.removeListener(updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltip: context.tr.clear,
      onPressed: _enabled ? () => widget.controller.clear() : null,
      icon: const Icon(Icons.clear_rounded),
      color: Theme.of(context).colorScheme.error,
    );
  }
}
