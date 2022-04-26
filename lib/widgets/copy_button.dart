import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:alga/utils/snackbar_util.dart';

class CopyButton extends StatelessWidget {
  final String Function(WidgetRef ref) onCopy;
  const CopyButton({Key? key, required this.onCopy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return IconButton(
          onPressed: () async {
            final data = onCopy(ref);
            await ClipboardUtil.copy(data);
            SnackbarUtil(context).copied();
          },
          icon: child!,
          tooltip: S.of(context).copy,
        );
      },
      child: const Icon(Icons.copy),
    );
  }
}
