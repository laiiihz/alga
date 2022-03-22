part of './base_64_encoder_decoder.dart';

final _isEncode = StateProvider.autoDispose<bool>((ref) => true);
final _input = StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});
final _result = StateProvider.autoDispose<String>((ref) {
  final isEncode = ref.watch(_isEncode);
  final text = ref.watch(_input).text;
  if (text.isEmpty) return '';
  if (isEncode) {
    final bytes = utf8.encode(text);
    return const Base64Encoder().convert(bytes);
  } else {
    try {
      Uint8List result = base64.decode(text);
      return utf8.decode(result);
    } catch (e) {
      return '';
    }
  }
});
