import 'dart:convert';

import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/material.dart';
import 'package:language_textfield/language_textfield.dart';

class UriParserProvider extends ChangeNotifier {
  late List<UriPart> parts;
  UriParserProvider() {
    parts = [
      UriPart(title: 'host', name: () => _uri?.host ?? ''),
      UriPart(
        title: 'origin',
        name: () {
          try {
            return _uri?.origin ?? '';
          } catch (e) {
            return '';
          }
        },
      ),
      UriPart(title: 'scheme', name: () => _uri?.scheme ?? ''),
      UriPart(title: 'port', name: () => _uri?.port.toString() ?? ''),
      UriPart(title: 'path', name: () => _uri?.path ?? ''),
      UriPart(
        title: 'params',
        name: () {
          Map<String, dynamic> raw = _uri?.queryParameters ?? {};
          final encoder = JsonEncoder.withIndent(' ' * 2);
          return encoder.convert(raw);
        },
        lang: LangHighlightType.json,
      ),
    ];
  }

  final inputController = TextEditingController();

  Uri? _uri;

  parse() {
    _uri = Uri.tryParse(inputController.text);
    notifyListeners();
  }

  paste() async {
    inputController.text = await ClipboardUtil.paste();
    parse();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}

class UriPart {
  final String title;
  final String Function() name;
  final String? lang;
  UriPart({
    required this.title,
    required this.name,
    this.lang,
  });
}
