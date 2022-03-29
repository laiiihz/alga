import 'package:js/js.dart';

@JS('window.eval')
external dynamic _eval(dynamic arg);

class JsStub {
  JsStub();
  void dispose() {}

  String evaluate(String code) {
    return _eval(code).toString();
  }
}
