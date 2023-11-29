import 'package:alga/l10n/l10n.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.maybeOf(context)?.showSnackBar(
    SnackBar(
      content: Text(message),
      action:
          SnackBarAction(label: context.mtr.okButtonLabel, onPressed: () {}),
    ),
  );
}
