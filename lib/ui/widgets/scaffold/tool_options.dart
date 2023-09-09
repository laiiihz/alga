import 'package:alga/ui/widgets/app_show_menu.dart';
import 'package:alga/utils/constants/import_helper.dart';

class ToolOptionsEnum<T extends Enum> extends ConsumerWidget {
  const ToolOptionsEnum({
    super.key,
    required this.provider,
    this.leading,
    required this.title,
    this.subtitle,
    required this.items,
    required this.l10n,
    required this.onSelect,
  });
  final ProviderListenable<T> provider;
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final List<T> items;
  final String Function(BuildContext context, T value) l10n;
  final void Function(T value) onSelect;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final T value = ref.watch(provider);
    return AppShowMenu<T>(
      items: items.map((e) {
        return PopupMenuItem<T>(value: e, child: Text(l10n(context, e)));
      }).toList(),
      childBuilder: (context, open) {
        return ToolViewConfig(
          leading: leading,
          title: title,
          subtitle: subtitle,
          onPressed: open,
          trailing: Chip(
            label: Text(l10n(context, value)),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
        );
      },
      initialValue: value,
      onSelected: (item) {
        onSelect(item);
      },
    );
  }
}
