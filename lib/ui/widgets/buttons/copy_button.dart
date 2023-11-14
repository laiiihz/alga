import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/utils/constants/import_helper.dart';

class CopyButton extends StatelessWidget {
  const CopyButton(this.onCopy, {super.key});

  final String Function() onCopy;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltip: context.tr.copy,
      onPressed: () {
        ClipboardUtil.copy(onCopy());
      },
      icon: const Icon(Icons.copy_rounded),
    );
  }
}
