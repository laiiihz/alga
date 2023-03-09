import 'package:flutter/material.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle(this.text, {super.key});
  final Widget text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: text,
      ),
    );
  }
}
