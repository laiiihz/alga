import 'dart:convert';

import 'package:alga/utils/constants/import_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'json_format.provider.g.dart';

enum JsonIndentType {
  space2('  '),
  space4('    '),
  tab('\t'),
  minified(null),
  ;

  const JsonIndentType(this.indent);

  final String? indent;

  String name(BuildContext context) {
    return switch (this) {
      JsonIndentType.space2 => S.of(context).json2spaces,
      JsonIndentType.space4 => S.of(context).json4spaces,
      JsonIndentType.tab => S.of(context).json1tab,
      JsonIndentType.minified => S.of(context).jsonMinified,
    };
  }
}

@Riverpod(keepAlive: true)
class JsonIndent extends _$JsonIndent {
  @override
  JsonIndentType build() => JsonIndentType.space2;

  change(JsonIndentType type) {
    state = type;
  }
}

@riverpod
class JsonContent extends _$JsonContent {
  @override
  Raw<RichTextController> build() {
    final controller = RichTextController.lang(type: HighlightType.json);
    ref.onDispose(controller.dispose);
    controller.addListener(() {
      ref.read(errorMessageProvider.notifier).clear();
    });
    return controller;
  }

  FutureOr format() async {
    try {
      final indent = ref.read(jsonIndentProvider);
      if (state.text.length < 1500) {
        state.text = _format((state.text, indent));
        return;
      } else {
        ref.read(jsonFormatLoadingProvider.notifier).update(true);
        state.text = await compute(_format, (state.text, indent));
      }
    } on FormatException catch (e) {
      ref.read(errorMessageProvider.notifier).update(e.message);
    } finally {
      ref.read(jsonFormatLoadingProvider.notifier).update(false);
    }
  }
}

@riverpod
class JsonFormatLoading extends _$JsonFormatLoading {
  @override
  bool build() => false;

  void update(bool value) => state = value;
}

@riverpod
class ErrorMessage extends _$ErrorMessage {
  @override
  String? build() => null;

  update(String? text) => state = text;
  clear() => state = null;
}

String _format((String data, JsonIndentType indent) params) {
  final jsonMap = const JsonDecoder().convert(params.$1);
  return JsonEncoder.withIndent(params.$2.indent).convert(jsonMap);
}
