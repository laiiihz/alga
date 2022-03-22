part of './uri_encoder_decoder.dart';

final _input = StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _isEncode = StateProvider.autoDispose((ref) => true);

final _result = StateProvider.autoDispose<String>((ref) {
  final isEncode = ref.watch(_isEncode);
  final text = ref.watch(_input).text;
  if (text.isEmpty) return '';
  return isEncode ? Uri.encodeFull(text) : Uri.decodeFull(text);
});
