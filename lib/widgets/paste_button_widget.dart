import 'package:alga/constants/import_helper.dart';
import 'package:alga/widgets/custom_icon_button.dart';

import '../utils/snackbar_util.dart';

class PasteButtonWidget extends ConsumerStatefulWidget {
  const PasteButtonWidget(
    this.controller, {
    super.key,
    required this.onUpdate,
  });
  final ProviderListenable<TextEditingController> controller;
  final void Function(WidgetRef ref) onUpdate;

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
        print(await ClipboardUtil.paste());
        print(ref.read(widget.controller).text);
        if (mounted) SnackbarUtil(context).pasted();
        widget.onUpdate(ref);
      },
      icon: const Icon(Icons.paste),
    );
  }
}
