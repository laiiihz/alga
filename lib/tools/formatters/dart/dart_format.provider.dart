import 'package:alga/utils/constants/import_helper.dart';
import 'package:dart_style/dart_style.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dart_format.provider.g.dart';

@riverpod
class DartFormatLoading extends _$DartFormatLoading {
  @override
  bool build() => false;

  update(bool value) => state = value;
}

@riverpod
class ErrorMessage extends _$ErrorMessage {
  @override
  String? build() => null;
  void update(String? value) => state = value;
  void clear() => state = null;
}

@riverpod
class DartContent extends _$DartContent {
  @override
  Raw<RichTextController> build() {
    final controller = RichTextController.lang(type: HighlightType.dart);
    ref.onDispose(controller.dispose);
    return controller;
  }

  FutureOr format() async {
    try {
      final text = state.text;
      if (text.length > 2000) {
        state.text = _format(text);
      } else {
        ref.read(dartFormatLoadingProvider.notifier).update(true);
        state.text = await compute(_format, text);
      }
    } catch (e) {
      ref.read(errorMessageProvider.notifier).update(e.toString());
    } finally {
      ref.read(dartFormatLoadingProvider.notifier).update(false);
    }
  }
}

String _format(String text) {
  return DartFormatter().format(text);
}
