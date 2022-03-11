import 'package:flutter/material.dart';

class UriParserProvider extends ChangeNotifier {
  final inputController = TextEditingController();
  Uri? uri;
  parse() {
    uri = Uri.tryParse(inputController.text);
    notifyListeners();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}
