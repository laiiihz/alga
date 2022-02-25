import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

enum UUIDVersion {
  v1,
  v4,
}

extension UUIDExt on UUIDVersion {
  String get value {
    switch (this) {
      case UUIDVersion.v1:
        return 'v1'.padRight(8);
      case UUIDVersion.v4:
        return 'v4'.padRight(8);
    }
  }
}

class UUIDProvider extends ChangeNotifier {
  final uuid = const Uuid();
  bool _hypens = false;
  bool get hypens => _hypens;
  set hypens(bool state) {
    _hypens = state;
    notifyListeners();
  }

  bool _upperCase = false;
  bool get upperCase => _upperCase;
  set upperCase(bool state) {
    _upperCase = state;
    notifyListeners();
  }

  UUIDVersion _version = UUIDVersion.v4;
  UUIDVersion get version => _version;
  set version(UUIDVersion state) {
    _version = state;
    notifyListeners();
  }

  int _count = 1;
  int get count => _count;
  set count(int value) {
    _count = value;
    notifyListeners();
  }

  TextEditingController resultController = TextEditingController();

  Future copy() async {
    await Clipboard.setData(ClipboardData(text: resultController.text));
  }

  String _genId() {
    switch (_version) {
      case UUIDVersion.v1:
        return uuid.v1();
      case UUIDVersion.v4:
        return uuid.v4();
    }
  }

  String _decoratedData() {
    String result = _genId();
    if (!_hypens) {
      result = result.replaceAll('-', '');
    }
    if (_upperCase) {
      result = result.toUpperCase();
    }
    return result;
  }

  generate() {
    List<String> results = List.generate(_count, (index) => _decoratedData());
    resultController.text = results.join('\n');
  }

  @override
  void dispose() {
    resultController.dispose();
    super.dispose();
  }
}
