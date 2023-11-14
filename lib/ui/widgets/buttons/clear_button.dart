import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ClearButton extends StatefulWidget {
  const ClearButton({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<ClearButton> createState() => _ClearButtonState();
}

class _ClearButtonState extends State<ClearButton> {
  void _update() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_update);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      tooltip: context.tr.clear,
      onPressed: widget.controller.text.isEmpty
          ? null
          : () {
              widget.controller.clear();
            },
      color: Theme.of(context).colorScheme.error,
      icon: const Icon(Icons.delete_rounded),
    );
  }
}
