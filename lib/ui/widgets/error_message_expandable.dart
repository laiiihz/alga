import 'package:alga/utils/constants/import_helper.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(this.message, {super.key});

  static Widget? get(String? message) {
    if (message == null) return null;
    return ErrorMessageWidget(message);
  }

  final String message;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        minimumSize: Size.zero,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              backgroundColor: colorScheme.errorContainer.withOpacity(0.5),
              title: const Text('Error'),
              content: Text(
                message * 3,
                style: TextStyle(color: colorScheme.onErrorContainer),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(context.mtr.okButtonLabel),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.error_rounded),
      label: Text(
        message,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
