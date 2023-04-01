import 'package:alga/utils/constants/import_helper.dart';
import 'package:pigment/pigment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_converter.provider.g.dart';

@riverpod
TextEditingController inputController(InputControllerRef ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  controller.addListener(() => ref.invalidate(colorProvider));
  return controller;
}

@riverpod
Color color(ColorRef ref) {
  final text = ref.watch(inputControllerProvider).text;
  if (text.isEmpty) return Colors.transparent;
  try {
    return Pigment.fromString(text);
  } catch (e) {
    return Colors.transparent;
  }
}

@riverpod
String hexValue(HexValueRef ref) {
  final color = ref.watch(colorProvider);
  return '#${color.value.toRadixString(16).padLeft(8, '0')}';
}

@riverpod
String rgb(RgbRef ref) {
  final color = ref.watch(colorProvider);
  return 'rgb(${color.red}, ${color.green}, ${color.blue})';
}

@riverpod
String rgba(RgbaRef ref) {
  final color = ref.watch(colorProvider);
  return 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.opacity})';
}

@riverpod
String hsl(HslRef ref) {
  final color = ref.watch(colorProvider);
  final hsl = HSLColor.fromColor(color);
  return 'hsl(${hsl.hue.toStringAsFixed(0)}, ${hsl.saturation.toStringAsFixed(2)}%, ${hsl.lightness.toStringAsFixed(2)}%)';
}

@riverpod
String hsv(HsvRef ref) {
  final color = ref.watch(colorProvider);
  final hsv = HSVColor.fromColor(color);
  return 'hsv(${hsv.hue.toStringAsFixed(0)}, ${hsv.saturation.toStringAsFixed(2)}%, ${hsv.value.toStringAsFixed(2)}%)';
}
