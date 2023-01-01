import 'package:alga/constants/import_helper.dart';
import 'package:alga/widgets/custom_icon_button.dart';

import '../utils/snackbar_util.dart';

class PasteButtonWidget extends StatefulWidget {
  const PasteButtonWidget(this.controller, {super.key});
  final TextEditingController controller;

  @override
  State<PasteButtonWidget> createState() => _PasteButtonWidgetState();
}

class _PasteButtonWidgetState extends State<PasteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltip: S.of(context).paste,
      onPressed: () async {
        widget.controller.text = await ClipboardUtil.paste();
        if (mounted) SnackbarUtil(context).pasted();
      },
      icon: const Icon(Icons.paste),
    );
  }
}
