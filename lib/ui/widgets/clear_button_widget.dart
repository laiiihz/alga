import 'package:alga/utils/constants/import_helper.dart';

import 'custom_icon_button.dart';

class ClearButtonWidget extends ConsumerStatefulWidget {
  const ClearButtonWidget(this.controller, {super.key, this.onUpdate});
  final ProviderListenable<TextEditingController> controller;
  final void Function(WidgetRef ref)? onUpdate;

  @override
  ConsumerState<ClearButtonWidget> createState() => _ClearButtonWidgetState();
}

class _ClearButtonWidgetState extends ConsumerState<ClearButtonWidget> {
  late bool _enabled;
  late TextEditingController _holdController;

  _update() {
    _enabled = _holdController.text.isNotEmpty;
  }

  _handleUpdate() {
    _update();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _holdController = ref.read(widget.controller);
    _update();
    _holdController.addListener(_handleUpdate);
  }

  @override
  void dispose() {
    _holdController.removeListener(_handleUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltip: context.tr.clear,
      onPressed: _enabled
          ? () {
              ref.watch(widget.controller).clear();
              widget.onUpdate?.call(ref);
            }
          : null,
      icon: const Icon(Icons.clear_rounded),
      color: Theme.of(context).colorScheme.error,
    );
  }
}
