part of 'regex_tester_app_view.dart';

final _regexTextProvider = StateProvider.autoDispose<String>((ref) => '');
final _multiLine = StateProvider.autoDispose<bool>((ref) => false);
final _caseSensitive = StateProvider.autoDispose<bool>((ref) => true);
final _unicode = StateProvider.autoDispose<bool>((ref) => false);
final _dotAll = StateProvider.autoDispose<bool>((ref) => false);
final _errorProvider = Provider.autoDispose<String?>((ref) {
  try {
    RegExp(ref.watch(_regexTextProvider));
    return null;
  } on FormatException catch (e) {
    return e.message;
  }
});

final _regexProvider = Provider.autoDispose<RegExp?>((ref) {
  try {
    final text = ref.watch(_regexTextProvider);
    if (text.isEmpty) return null;
    return RegExp(
      text,
      multiLine: ref.watch(_multiLine),
      caseSensitive: ref.watch(_caseSensitive),
      unicode: ref.watch(_unicode),
      dotAll: ref.watch(_dotAll),
    );
  } on FormatException catch (_) {
    return null;
  }
});
