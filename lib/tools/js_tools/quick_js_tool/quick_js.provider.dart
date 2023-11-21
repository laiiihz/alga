import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_js/flutter_js.dart';
part 'quick_js.provider.g.dart';

sealed class JsContent {
  const JsContent(this.value);

  final String value;
}

class InContent extends JsContent {
  const InContent(super.value);
}

class OutContent extends JsContent {
  const OutContent(super.value);
}

@Riverpod(keepAlive: true)
JavascriptRuntime jsEngine(JsEngineRef ref) {
  return getJavascriptRuntime();
}

@riverpod
class JsContents extends _$JsContents {
  @override
  List<JsContent> build() => [];

  void exec(String content) async {
    final engine = ref.watch(jsEngineProvider);
    state = [InContent(content), ...state];
    final result = await engine.evaluateAsync(content);
    state = [OutContent(result.stringResult), ...state];
  }

  clear() {
    state = [];
  }
}

@riverpod
Raw<TextEditingController> jsInputController(JsInputControllerRef ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
}
