import 'package:alga/l10n/l10n.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CopyButton extends StatelessWidget {
  final String Function(WidgetRef ref) onCopy;
  const CopyButton({Key? key, required this.onCopy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return IconButton(
          onPressed: () async {
            await ClipboardUtil.copy(onCopy(ref));
          },
          icon: child!,
          tooltip: S.of(context).copy,
        );
      },
      child: const Icon(Icons.copy),
    );
  }
}
