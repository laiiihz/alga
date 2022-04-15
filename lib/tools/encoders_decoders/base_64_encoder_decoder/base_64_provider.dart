part of './base_64_encoder_decoder.dart';

final _isEncode = StateProvider.autoDispose<bool>((ref) => true);
final _urlSafe = StateProvider.autoDispose<bool>((ref) => false);
final _input = StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});
final _result = StateProvider.autoDispose<String>((ref) {
  final isEncode = ref.watch(_isEncode);
  final text = ref.watch(_input).text;
  final urlSafe = ref.watch(_urlSafe);
  if (text.isEmpty) return '';
  if (isEncode) {
    final bytes = utf8.encode(text);
    final codec = urlSafe ? const Base64Codec.urlSafe() : const Base64Codec();
    return codec.encode(bytes);
  } else {
    try {
      Uint8List result = base64.decode(text);
      return utf8.decode(result);
    } catch (e) {
      return '';
    }
  }
});
