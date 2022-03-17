import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../abstract/generator_base.dart';

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
  String typeName(BuildContext context) {
    switch (this) {
      case HashType.md5:
        return 'md5';
      case HashType.sha1:
        return 'sha1';
      case HashType.sha224:
        return 'sha224';
      case HashType.sha256:
        return 'sha256';
      case HashType.sha384:
        return 'sha384';
      case HashType.sha512:
        return 'sha512';
      case HashType.sha512224:
        return 'sha512/224';
      case HashType.sha512256:
        return 'sha512/256';
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

VoidCallback disposeAllControllers(List<HashTypeWrapper> controllers) {
  return () {
    for (var item in controllers) {
      item.dispose();
    }
  };
}

// final hmacControllers = StateProvider.autoDispose<List<HMACResult>>(
//     (ref) => HashType.values.map((e) => HMACResult.fromEmpty(e)).toList());

final inputController = StateProvider.autoDispose<TextEditingController>((ref) {
  final ctrl = TextEditingController();
  ref.onDispose(() => ctrl.dispose());
  return ctrl;
});
final optionalController =
    StateProvider.autoDispose<TextEditingController>((ref) {
  final ctrl = TextEditingController();
  ref.onDispose(() => ctrl.dispose());
  return ctrl;
});

final hashUpperCase = StateProvider.autoDispose<bool>((ref) => false);
final showHmac = StateProvider.autoDispose<bool>((ref) => false);

final hashResults = StateProvider.autoDispose<List<HashResult>>((ref) {
  bool _showHmac = ref.watch(showHmac);
  bool _upperCase = ref.watch(hashUpperCase);
  String _input = ref.watch(inputController).text;
  String _optional = ref.watch(optionalController).text;

  final results = <HashResult>[];
  for (var item in HashType.values) {
    final _converter = _Converter(item);
    if (!_showHmac) {
      String normal = _converter.convert(_input).toString();
      if (_upperCase) normal = normal.toUpperCase();
      results.add(HashResult(type: item, result: normal));
    } else {
      String hmacData =
          _converter.convertWithSecret(_input, _optional).toString();
      if (_upperCase) hmacData = hmacData.toUpperCase();
      results.add(HMACResult(type: item, result: hmacData));
    }
  }

  return results;
});

class HashProvider extends GeneratorBase {
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

  bool _showHmac = false;
  bool get showHmac => _showHmac;
  set showHmac(bool state) {
    _showHmac = state;
    notifyListeners();
  }

  setInputFormClipboard() async {
    final res = await Clipboard.getData('text/plain');
    if (res?.text == null) return;
    inputController.text = res!.text!;
  }

  @override
  generate() {
    if (_showHmac) {
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
    } else {
      for (var item in controllers) {
        String result = item.convert(inputController.text).toString();
        if (_upperCase) {
          result = result.toUpperCase();
        }
        item.controller.text = result;
      }
    }
  }

  @override
  clear() {
    for (var item in controllers) {
      item.controller.clear();
    }
    for (var item in hmacControllers) {
      item.controller.clear();
    }
    inputController.clear();
    optionalController.clear();
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

  String title(BuildContext context) => type.typeName(context);

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
  String title(BuildContext context) => 'HMAC:${super.title(context)}';
}

class HashResult {
  final HashType type;
  final String result;
  HashResult({
    required this.type,
    required this.result,
  });

  String title(BuildContext context) => type.typeName(context);

  copy() async {
    await Clipboard.setData(ClipboardData(text: result));
  }
}

class HMACResult extends HashResult {
  HMACResult({required HashType type, required String result})
      : super(type: type, result: result);
  @override
  String title(BuildContext context) => 'HMAC:${super.title(context)}';
}

class _Converter {
  final HashType type;
  const _Converter(this.type);
  Digest convert(String data) {
    final raw = utf8.encode(data);
    return type.hashObject.convert(raw);
  }

  Digest convertWithSecret(String data, String secret) {
    final secretBinary = utf8.encode(secret);
    final raw = utf8.encode(data);
    final hmac = Hmac(type.hashObject, secretBinary);
    return hmac.convert(raw);
  }
}
