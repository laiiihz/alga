import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum HashType {
  md5,
  sha1,
  sha224,
  sha256,
  sha384,
  sha512,
  sha512224,
  sha512256,
}

extension HashTypeExt on HashType {
  String get value {
    switch (this) {
      case HashType.md5:
        return 'md5'.padRight(10);
      case HashType.sha1:
        return 'sha1'.padRight(10);
      case HashType.sha224:
        return 'sha224'.padRight(10);
      case HashType.sha256:
        return 'sha256'.padRight(10);
      case HashType.sha384:
        return 'sha384'.padRight(10);
      case HashType.sha512:
        return 'sha512'.padRight(10);
      case HashType.sha512224:
        return 'sha512/224'.padRight(10);
      case HashType.sha512256:
        return 'sha512/256'.padRight(10);
    }
  }

  Hash get hashObject {
    switch (this) {
      case HashType.md5:
        return md5;
      case HashType.sha1:
        return sha1;
      case HashType.sha224:
        return sha224;
      case HashType.sha256:
        return sha256;
      case HashType.sha384:
        return sha384;
      case HashType.sha512:
        return sha512;
      case HashType.sha512224:
        return sha512224;
      case HashType.sha512256:
        return sha512256;
    }
  }
}

class HashProvider extends ChangeNotifier {
  HashProvider() {
    controllers = HashType.values
        .map((e) =>
            HashTypeWrapper(type: e, controller: TextEditingController()))
        .toList();

    hmacControllers = HashType.values
        .map((e) =>
            _HMACTypeWrapper(type: e, controller: TextEditingController()))
        .toList();
  }

  late List<HashTypeWrapper> controllers;
  late List<_HMACTypeWrapper> hmacControllers;
  TextEditingController inputController = TextEditingController();
  TextEditingController optionalController = TextEditingController();

  bool _upperCase = false;
  bool get upperCase => _upperCase;
  set upperCase(bool state) {
    _upperCase = state;
    notifyListeners();
  }

  setInputFormClipboard() async {
    final res = await Clipboard.getData('text/plain');
    if (res?.text == null) return;
    inputController.text = res!.text!;
  }

  generate() {
    for (var item in controllers) {
      String result = item.convert(inputController.text).toString();
      if (_upperCase) {
        result = result.toUpperCase();
      }
      item.controller.text = result;
    }
    for (var item in hmacControllers) {
      String result = item
          .convertWithSecret(
            inputController.text,
            optionalController.text,
          )
          .toString();
      if (_upperCase) {
        result = result.toUpperCase();
      }
      item.controller.text = result;
    }
  }

  @override
  dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var controller in hmacControllers) {
      controller.dispose();
    }
    inputController.dispose();
    optionalController.dispose();

    super.dispose();
  }
}

class HashTypeWrapper {
  final HashType type;
  final TextEditingController controller;
  HashTypeWrapper({
    required this.type,
    required this.controller,
  });

  String get title => type.value;

  Digest convert(String data) {
    final raw = utf8.encode(data);
    return type.hashObject.convert(raw);
  }

  copy() async {
    await Clipboard.setData(ClipboardData(text: controller.text));
  }

  dispose() {
    controller.dispose();
  }
}

class _HMACTypeWrapper extends HashTypeWrapper {
  _HMACTypeWrapper({
    required HashType type,
    required TextEditingController controller,
  }) : super(type: type, controller: controller);

  Digest convertWithSecret(String data, String secret) {
    final secretBinary = utf8.encode(secret);
    final raw = utf8.encode(data);
    final hmac = Hmac(type.hashObject, secretBinary);
    return hmac.convert(raw);
  }

  @override
  String get title => 'HMAC:${super.title}';
}
