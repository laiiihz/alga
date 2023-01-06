import 'package:alga/constants/import_helper.dart';
import 'package:alga/widgets/custom_icon_button.dart';

class RefreshButton<T> extends ConsumerWidget {
  const RefreshButton(this.provider, {super.key});
  final Refreshable<T> provider;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomIconButton(
      tooltip: context.tr.refresh,
      onPressed: () => ref.refresh<T>(provider),
      icon: const Icon(Icons.refresh_rounded),
    );
  }
}
