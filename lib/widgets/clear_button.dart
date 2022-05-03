import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/utils/snackbar_util.dart';

class ClearButton extends StatelessWidget {
  final Function(WidgetRef ref) onClear;
  const ClearButton({Key? key, required this.onClear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return IconButton(
          onPressed: () async {
            onClear(ref);
            SnackbarUtil(context).copied();
          },
          icon: child!,
          tooltip: S.of(context).copy,
        );
      },
      child: const Icon(Icons.clear_rounded),
    );
  }
}
