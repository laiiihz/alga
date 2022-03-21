part of './date_parser_view.dart';

final _dateController = StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _formatController =
    StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _date = StateProvider.autoDispose<DateTime?>((ref) {
  final date = ref.watch(_dateController).text;
  return DateTime.tryParse(date);
});

final _formatResult = StateProvider.autoDispose<String?>((ref) {
  final date = ref.watch(_date);
  final format = ref.watch(_formatController).text;
  if (date == null) return null;
  return DateFormat(format).format(date);
});
