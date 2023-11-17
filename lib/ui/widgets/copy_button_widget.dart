import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/utils/snackbar_util.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';

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

@Deprecated('use CopyButton')
class CopyButton2 extends ConsumerStatefulWidget {
  const CopyButton2(this.controller, {super.key});

  final ProviderListenable<TextEditingController> controller;

  @override
  ConsumerState<CopyButton2> createState() => _CopyButton2State();
}

class _CopyButton2State extends ConsumerState<CopyButton2> {
  late bool _enabled;
  late TextEditingController _holdController;
  _update() {
    _enabled = _holdController.text.isNotEmpty;
  }

  _handleUpdate() {
    _update();
    setState(() {});
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
      tooltip: context.tr.copy,
      onPressed: _enabled
          ? () async {
              await ClipboardUtil.copy(ref.read(widget.controller).text);
              if (mounted) SnackbarUtil(context).copied();
            }
          : null,
      icon: const Icon(Icons.copy_rounded),
    );
  }
}

@Deprecated('use CopyButton')
class CopyButtonWithText extends ConsumerStatefulWidget {
  const CopyButtonWithText(AutoDisposeProvider<String> cText, {super.key})
      : text = cText,
        raw = null;
  const CopyButtonWithText.raw(this.raw, {super.key}) : text = null;
  final AutoDisposeProvider<String>? text;
  final String? raw;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CopyButtonWithTextState();
}

class _CopyButtonWithTextState extends ConsumerState<CopyButtonWithText> {
  @override
  Widget build(BuildContext context) {
    String theText = widget.raw ?? '';
    if (widget.text != null) {
      theText = ref.watch(widget.text!);
    }

    return CustomIconButton(
      tooltip: context.tr.copy,
      onPressed: theText.isNotEmpty
          ? () async {
              await ClipboardUtil.copy(theText);
              if (mounted) SnackbarUtil(context).copied();
            }
          : null,
      icon: const Icon(Icons.copy_rounded),
    );
  }
}
