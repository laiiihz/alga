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

final _hexValue = StateProvider.autoDispose<String>((ref) {
  final color = ref.watch(_colorProvider);
  return '#${color.value.toRadixString(16).padLeft(8, '0')}';
});

final _rgbValue = StateProvider.autoDispose<String>((ref) {
  final color = ref.watch(_colorProvider);
  return 'rgb(${color.red}, ${color.green}, ${color.blue})';
});

final _rgbaValue = StateProvider.autoDispose<String>((ref) {
  final color = ref.watch(_colorProvider);
  return 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.opacity})';
});

final _hslValue = StateProvider.autoDispose<String>((ref) {
  final color = ref.watch(_colorProvider);
  final hsl = HSLColor.fromColor(color);
  return 'hsl(${hsl.hue}, ${hsl.saturation}%, ${hsl.lightness}%)';
});

final _hsvValue = StateProvider.autoDispose<String>((ref) {
  final color = ref.watch(_colorProvider);
  final hsv = HSVColor.fromColor(color);
  return 'hsv(${hsv.hue}, ${hsv.saturation}%, ${hsv.value}%)';
});
