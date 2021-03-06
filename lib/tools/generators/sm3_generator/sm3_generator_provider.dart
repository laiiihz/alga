part of './sm3_generator_view.dart';

final _inputController =
    StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

final _inputValue = StateProvider.autoDispose<String>((ref) {
  final text = ref.read(_inputController).text;
  if (text.isEmpty) return '';
  var sm3 = SM3Digest();
  Uint8List result = sm3.process(Uint8List.fromList(utf8.encode(text)));
  return hex.encode(result);
});
