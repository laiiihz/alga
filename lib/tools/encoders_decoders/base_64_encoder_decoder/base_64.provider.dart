import 'dart:convert';
import 'dart:typed_data';

import 'package:alga/utils/constants/import_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'base_64.provider.g.dart';

@riverpod
class IsEncode extends _$IsEncode {
  @override
  bool build() => true;

  void update(bool state) => this.state = state;
}

@riverpod
class UrlSafe extends _$UrlSafe {
  @override
  bool build() => false;

  void update(bool state) => this.state = state;
}

@riverpod
TextEditingController inputController(InputControllerRef ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  controller.addListener(() => ref.invalidate(inputTextProvider));
  return controller;
}

@riverpod
String inputText(InputTextRef ref) => ref.watch(inputControllerProvider).text;

@riverpod
String result(ResultRef ref) {
  final isEncode = ref.watch(isEncodeProvider);
  final text = ref.watch(inputTextProvider);
  final urlSafe = ref.watch(urlSafeProvider);
  if (text.isEmpty) return '';
  if (isEncode) {
    final bytes = utf8.encode(text);
    final codec = urlSafe ? const Base64Codec.urlSafe() : const Base64Codec();
    return codec.encode(bytes);
  } else {
    try {
      Uint8List result = base64.decode(text);
      return utf8.decode(result);
    } catch (e) {
      return '';
    }
  }
}
