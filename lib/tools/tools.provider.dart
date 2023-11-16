import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tools.provider.g.dart';

@riverpod
class BooleanConfig extends _$BooleanConfig {
  @override
  bool build(Key key, {bool defaultValue = false}) => defaultValue;

  void change() {
    state = !state;
  }
}

@riverpod
class StringConfig extends _$StringConfig {
  @override
  String build(Key key, {String defaultValue = ''}) => defaultValue;

  void change(String data) {
    state = data;
  }
}

@riverpod
class ErrorText extends _$ErrorText {
  @override
  String? build(Key? key) => null;

  void change(String? data) {
    state = data;
  }

  void clear() {
    state = null;
  }
}

@riverpod
class IntConfig extends _$IntConfig {
  @override
  int build(Key key, {int defaultValue = 1}) => defaultValue;

  void change(int data) {
    state = data;
  }
}
