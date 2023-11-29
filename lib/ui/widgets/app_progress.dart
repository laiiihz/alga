import 'dart:async';

import 'package:alga/utils/constants/import_helper.dart';
import 'package:bot_toast/bot_toast.dart';

Future<T> progress<T>(Future<T> Function() runner, {String? message}) async {
  final cancel = BotToast.showCustomLoading(
    toastBuilder: (cancel) {
      return Builder(builder: (context) {
        return Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator.adaptive(),
                if (message != null) ...[
                  const SizedBox(height: 8),
                  Text(message),
                ],
              ],
            ),
          ),
        );
      });
    },
  );
  final result = await runner();
  cancel();

  return result;
}
