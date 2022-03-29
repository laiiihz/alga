import 'package:flutter_js/flutter_js.dart';

class JsStub {
  late JavascriptRuntime _runtime;
  JsStub() {
    _runtime = getJavascriptRuntime();
  }

  dispose() {
    _runtime.dispose();
  }

  String evaluate(String code) {
    return _runtime.evaluate(code).stringResult;
  }
}
