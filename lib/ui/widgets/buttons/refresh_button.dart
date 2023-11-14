import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/utils/constants/import_helper.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton(this.onRefresh, {super.key});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltip: context.tr.refresh,
      onPressed: onRefresh,
      icon: const Icon(Icons.refresh_rounded),
    );
  }
}
