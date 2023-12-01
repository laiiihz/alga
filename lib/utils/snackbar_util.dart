import 'package:alga/l10n/l10n.dart';
import 'package:flutter/material.dart';

class SnackbarUtil {
  final BuildContext context;
  SnackbarUtil(this.context);

  success(String text) {
    final scheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: scheme.secondary,
        action: SnackBarAction(
          label: context.tr.confirm,
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
          },
        ),
      ),
    );
  }

  fail(String text) {
    final scheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: scheme.error,
        action: SnackBarAction(
          label: context.tr.confirm,
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
          },
        ),
      ),
    );
  }

  copied() {
    success(context.tr.copied);
  }

  pasted() {
    success(context.tr.pasted);
  }

  cleared() {
    success(context.tr.cleared);
  }
}
