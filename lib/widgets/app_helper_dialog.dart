import 'package:alga/l10n/l10n.dart';
import 'package:flutter/material.dart';

Future showHelpDialog({
  required BuildContext context,
  required Widget title,
  required Widget content,
}) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(S.of(context).confirm),
          ),
        ],
      );
    },
  );
}

class HelperIconButton extends StatelessWidget {
  final Widget title;
  final Widget content;
  const HelperIconButton({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showHelpDialog(context: context, title: title, content: content);
      },
      icon: const Icon(Icons.help_outline),
    );
  }
}
