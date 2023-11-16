import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/app_show_menu.dart';
import 'package:alga/utils/constants/import_helper.dart';
import 'package:flutter/services.dart';

class VisibleConfig extends StatelessWidget {
  const VisibleConfig({
    super.key,
    required this.state,
    required this.first,
    required this.second,
  });
  final bool state;
  final Widget first;
  final Widget second;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: AnimatedSize(
        duration: kThemeAnimationDuration,
        curve: Curves.easeInOutCubic,
        child: state ? first : second,
      ),
    );
  }
}

class CrossFade extends StatelessWidget {
  const CrossFade({
    super.key,
    required this.state,
    required this.first,
    this.second,
  });
  final bool state;
  final Widget first;
  final Widget? second;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: first,
      secondChild: second ?? const SizedBox.shrink(),
      crossFadeState:
          state ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: kThemeAnimationDuration,
      sizeCurve: Curves.easeInOutCubic,
    );
  }
}

class ConfigSwitch extends ConsumerWidget {
  const ConfigSwitch({
    super.key,
    this.subtitle,
    this.leading,
    required this.title,
    required this.value,
  });
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final BooleanConfigProvider value;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToolViewConfig(
      title: title,
      subtitle: subtitle,
      leading: leading,
      onPressed: () {
        ref.read(value.notifier).change();
      },
      trailing: Switch(
        value: ref.watch(value),
        onChanged: (t) {
          ref.read(value.notifier).change();
        },
      ),
    );
  }
}

class ConfigMenu<T> extends ConsumerWidget {
  const ConfigMenu({
    super.key,
    required this.items,
    required this.getName,
    this.leading,
    required this.title,
    this.subtitle,
    required this.initItem,
    required this.onSelect,
  });
  final List<T> items;
  final String Function(T e) getName;
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final T initItem;
  final void Function(T e) onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppMenuWrapper<T>(
      items: items,
      getName: getName,
      childBuilder: (context, open) {
        return ToolViewConfig(
          leading: leading,
          title: title,
          subtitle: subtitle,
          onPressed: open,
          trailing: Text(
            getName(initItem),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        );
      },
      initialValue: initItem,
      onSelected: onSelect,
    );
  }
}

class ConfigTextField extends ConsumerStatefulWidget {
  const ConfigTextField({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.expanded = false,
    this.inputFormatters,
    this.onEditingComplete,
    this.hint,
    this.width,
    this.enabled,
    required this.provider,
    this.validator,
  });
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final bool expanded;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(WidgetRef ref)? onEditingComplete;
  final String? hint;
  final double? width;
  final bool? enabled;
  final StringConfigProvider provider;
  final FormFieldValidator<String?>? validator;
  @override
  ConsumerState<ConfigTextField> createState() => _ConfigTextFieldState();
}

class _ConfigTextFieldState extends ConsumerState<ConfigTextField> {
  final _focusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(widget.provider));
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.onEditingComplete?.call(ref);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(widget.provider);
    final textField = TextFormField(
      focusNode: _focusNode,
      controller: _controller,
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
      validator: widget.validator,
      onEditingComplete: () {
        if (!_form.currentState!.validate()) {
          return;
        }
        ref.read(widget.provider.notifier).change(_controller.text);
        _focusNode.unfocus();
      },
    );
    return Form(
      key: _form,
      child: ToolViewConfig(
        title: widget.title,
        leading: widget.leading,
        subtitle: widget.expanded ? textField : widget.subtitle,
        onPressed: () {
          _focusNode.requestFocus();
        },
        trailing: widget.expanded
            ? null
            : SizedBox(width: widget.width ?? 84, child: textField),
      ),
    );
  }
}

class ConfigNumber extends ConsumerWidget {
  const ConfigNumber({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.min = 0,
    this.max = 99,
    required this.value,
    this.displayValue,
  });
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final int min;
  final int max;
  final IntConfigProvider value;
  final String Function(int value)? displayValue;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(value);
    final displayText = displayValue?.call(current) ?? current.toString();

    return ToolViewConfig(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.filledTonal(
            style: IconButton.styleFrom(
              minimumSize: const Size.square(32),
              padding: EdgeInsets.zero,
            ),
            onPressed: current <= min
                ? null
                : () {
                    ref.read(value.notifier).change(current - 1);
                  },
            icon: const Icon(Icons.remove),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Material(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  displayText,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ),
          IconButton.filledTonal(
            style: IconButton.styleFrom(
              minimumSize: const Size.square(32),
              padding: EdgeInsets.zero,
            ),
            onPressed: current >= max
                ? null
                : () {
                    ref.read(value.notifier).change(current + 1);
                  },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}
