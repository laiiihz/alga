// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/utils/extension/list_ext.dart';
import 'package:alga/ui/widgets/app_show_menu.dart';
import 'package:flutter/services.dart';

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
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: DefaultTextStyle.merge(
        style: TextStyle(color: scheme.onSecondaryContainer),
        child: title,
      ),
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      tileColor: scheme.secondaryContainer,
      onTap: onPressed,
    );
  }
}

class ToolViewWrapper extends StatelessWidget {
  /// normally a list of [ToolViewConfig]
  final List<Widget> children;

  const ToolViewWrapper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    // add a material to prevent [ListTile][Ink] render issue.
    // related: https://github.com/flutter/flutter/issues/105760
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          AppTitle(title: S.of(context).configuration),
          const SizedBox(height: 8),
          ...children.sep(const SizedBox(height: 4)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

@Deprecated('use AlgaConfigSwitch')
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

class ToolViewMenuConfig<T> extends ConsumerWidget {
  const ToolViewMenuConfig({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    required this.initialValue,
    required this.items,
    required this.onSelected,
    required this.name,
  });
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final T Function(WidgetRef ref) initialValue;
  final List<PopupMenuEntry<T>> items;
  final void Function(T, WidgetRef) onSelected;
  final String Function(WidgetRef ref) name;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppShowMenu<T>(
      items: items,
      childBuilder: (context, open) {
        return ToolViewConfig(
          leading: leading,
          title: title,
          subtitle: subtitle,
          onPressed: open,
          trailing: Text(
            name(ref),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        );
      },
      initialValue: initialValue(ref),
      onSelected: (item) {
        onSelected(item, ref);
      },
    );
  }
}

class ToolViewTextField extends ConsumerStatefulWidget {
  const ToolViewTextField({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.controller,
    this.inputFormatters,
    this.onEditingComplete,
    this.hint,
    this.expanded = false,
    this.width,
    this.enabled,
  });
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final bool expanded;
  final ProviderListenable<TextEditingController>? controller;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(WidgetRef ref)? onEditingComplete;
  final String? hint;
  final double? width;
  final bool? enabled;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ToolViewTextFieldState();
}

class _ToolViewTextFieldState extends ConsumerState<ToolViewTextField> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.onEditingComplete?.call(ref);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textField = TextField(
      focusNode: _focusNode,
      controller:
          widget.controller != null ? ref.watch(widget.controller!) : null,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        hintText: widget.hint,
      ),
      enabled: widget.enabled,
      onEditingComplete: () {
        widget.onEditingComplete?.call(ref);
        _focusNode.unfocus();
      },
    );
    return ToolViewConfig(
      title: widget.title,
      leading: widget.leading,
      subtitle: widget.expanded ? textField : widget.subtitle,
      onPressed: () {
        _focusNode.requestFocus();
      },
      trailing: widget.expanded
          ? null
          : SizedBox(
              width: widget.width ?? 84,
              child: textField,
            ),
    );
  }
}

class AlgaConfigSwitch extends ConsumerWidget {
  const AlgaConfigSwitch({
    super.key,
    this.subtitle,
    this.leading,
    required this.title,
    required this.value,
  });
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final AutoDisposeStateProvider<bool> value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToolViewConfig(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: Switch(
        value: ref.watch(value),
        onChanged: (value) {
          ref.read(this.value.notifier).update((state) => value);
        },
      ),
      onPressed: () {
        ref.read(value.notifier).update((state) => !state);
      },
    );
  }
}

class AlgaSwitch extends ConsumerWidget {
  const AlgaSwitch({
    super.key,
    this.subtitle,
    this.leading,
    required this.title,
    required this.value,
    required this.onChanged,
  });
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final bool Function(WidgetRef ref) value;
  final void Function(WidgetRef ref, bool value) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = value(ref);
    return ToolViewConfig(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: Switch(
        value: current,
        onChanged: (value) {
          onChanged(ref, value);
        },
      ),
      onPressed: () {
        onChanged(ref, !current);
      },
    );
  }
}
