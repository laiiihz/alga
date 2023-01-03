import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/snackbar_util.dart';
import 'package:alga/widgets/custom_icon_button.dart';

class CopyButtonWidget extends ConsumerStatefulWidget {
  const CopyButtonWidget({
    super.key,
    this.text,
    this.controller,
    this.refText,
  });

  final TextEditingController? controller;
  final String? text;
  final String Function(WidgetRef ref)? refText;

  @override
  ConsumerState<CopyButtonWidget> createState() => _CopyButtonWidgetState();
}

class _CopyButtonWidgetState extends ConsumerState<CopyButtonWidget> {
  String get _text {
    if (widget.refText != null) {
      return widget.refText!.call(ref);
    }
    if (widget.controller != null) {
      return widget.controller!.text;
    }
    return widget.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return CustomIconButton(
          tooltip: context.tr.copy,
          onPressed: () async {
            await ClipboardUtil.copy(_text);
            if (mounted) SnackbarUtil(context).copied();
          },
          icon: const Icon(Icons.copy_rounded),
        );
      },
    );
  }
}
