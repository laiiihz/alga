// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alga/constants/import_helper.dart';
import 'package:alga/extension/list_ext.dart';

class ToolViewConfig extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  const ToolViewConfig({
    super.key,
    required this.title,
    this.trailing,
    this.leading,
    this.subtitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      tileColor: Theme.of(context).colorScheme.onInverseSurface,
      onTap: onPressed,
    );
  }
}

class ToolViewWrapper extends StatelessWidget {
  /// normally a list of [ToolViewConfig]
  final List<Widget> children;

  const ToolViewWrapper({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTitle(title: S.of(context).configuration),
        const SizedBox(height: 8),
        ...children.sep(const SizedBox(height: 4)),
        const SizedBox(height: 8),
      ],
    );
  }
}

class ToolViewSwitchConfig extends ConsumerWidget {
  const ToolViewSwitchConfig({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.value,
    this.onChanged,
  });
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final void Function(bool value, WidgetRef ref)? onChanged;
  final bool Function(WidgetRef ref) value;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool currentState = value(ref);
    return ToolViewConfig(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: Switch(
        value: currentState,
        onChanged: (value) {
          onChanged?.call(value, ref);
        },
      ),
      onPressed: () {
        onChanged?.call(!currentState, ref);
      },
    );
  }
}
