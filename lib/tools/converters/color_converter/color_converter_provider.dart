part of 'color_converter_view.dart';

final _inputController =
    StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _colorProvider = StateProvider.autoDispose<Color>((ref) {
  final text = ref.watch(_inputController).text;
  if (text.isEmpty) return Colors.transparent;
  try {
    final pigment = Pigment.fromString(text);
    return pigment;
  } catch (e) {
    return Colors.transparent;
  }
});
