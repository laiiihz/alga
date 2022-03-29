part of './quick_js_view.dart';

final _runtime = StateProvider.autoDispose<JsStub>((ref) {
  final runtime = JsStub();
  ref.onDispose(runtime.dispose);
  return runtime;
});

final _input = StateProvider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _result = StateProvider.autoDispose<String>((ref) {
  final runtime = ref.watch(_runtime);
  final text = ref.watch(_input).text;
  if (text.isEmpty) return '';
  return runtime.evaluate(text);
});
