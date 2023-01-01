import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/snackbar_util.dart';
import 'package:alga/widgets/custom_icon_button.dart';

class CopyButtonWidget extends StatefulWidget {
  const CopyButtonWidget(this.controller, {super.key});

  final TextEditingController controller;
  @override
  State<CopyButtonWidget> createState() => _CopyButtonWidgetState();
}

class _CopyButtonWidgetState extends State<CopyButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltip: context.tr.copy,
      onPressed: () async {
        await ClipboardUtil.copy(widget.controller.text);
        if (mounted) SnackbarUtil(context).copied();
      },
      icon: const Icon(Icons.copy_rounded),
    );
  }
}
