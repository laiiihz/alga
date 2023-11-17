import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';

import '../../utils/snackbar_util.dart';

@Deprecated('use ToolbarPaste')
class PasteButtonWidget extends ConsumerStatefulWidget {
  const PasteButtonWidget(
    this.controller, {
    super.key,
    this.onUpdate,
  });
  final ProviderListenable<TextEditingController> controller;
  final void Function(WidgetRef ref)? onUpdate;

  @override
  ConsumerState<PasteButtonWidget> createState() => _PasteButtonWidgetState();
}

class _PasteButtonWidgetState extends ConsumerState<PasteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltip: S.of(context).paste,
      onPressed: () async {
        ref.read(widget.controller).text = await ClipboardUtil.paste();
        if (mounted) SnackbarUtil(context).pasted();
        widget.onUpdate?.call(ref);
      },
      icon: const Icon(Icons.paste),
    );
  }
}
