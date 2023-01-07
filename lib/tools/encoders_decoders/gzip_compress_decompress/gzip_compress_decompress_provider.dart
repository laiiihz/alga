part of './gzip_compress_decompress_view.dart';

final _isCompress = StateProvider.autoDispose<bool>((ref) => true);

final _input = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _inputText = Provider.autoDispose((ref) => ref.watch(_input).text);

final _result = Provider.autoDispose<String>((ref) {
  final compress = ref.watch(_isCompress);
  final text = ref.watch(_inputText);
  if (text.isEmpty) return '';
  try {
    if (compress) {
      final encoder = GZipEncoder();
      const base64Encoder = Base64Encoder();
      final result = encoder.encode(utf8.encode(text));
      if (result == null) return '';
      return base64Encoder.convert(result);
    } else {
      final decoder = GZipDecoder();
      const base64Decoder = Base64Decoder();
      Uint8List result = base64Decoder.convert(text);
      return utf8.decode(decoder.decodeBytes(result));
    }
  } catch (e) {
    return '';
  }
});
