import 'package:alga/utils/constants/import_helper.dart';
import 'package:flutter/cupertino.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(this.message, {super.key});

  static Widget? get(String? message) {
    if (message == null) return null;
    return ErrorMessageWidget(message);
  }

  final String message;
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        showAdaptiveDialog(
          context: context,
          builder: (context) {
            return AlertDialog.adaptive(
              title: const Text('Error'),
              content: Text(message),
              actions: [
                AdaptiveDialogAction(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(context.mtr.okButtonLabel),
                ),
              ],
            );
          },
        );
      },
      highlightShape: BoxShape.rectangle,
      radius: 32,
      child: Text(
        message,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class AdaptiveDialogAction extends StatelessWidget {
  const AdaptiveDialogAction(
      {super.key, required this.onPressed, required this.child});
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }
}
