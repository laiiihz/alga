part of './quick_js_view.dart';

final _runtime = StateProvider.autoDispose<JavascriptRuntime>((ref) {
  final runtime = getJavascriptRuntime();
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
  final result = runtime.evaluate(text);
  return result.stringResult;
});
