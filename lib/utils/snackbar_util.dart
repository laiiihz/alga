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
          label: S.of(context).confirm,
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
          label: S.of(context).confirm,
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
          },
        ),
      ),
    );
  }

  copied() {
    success(S.of(context).copied);
  }

  pasted() {
    success(S.of(context).pasted);
  }
}
