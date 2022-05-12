import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  bool showHmacData = ref.watch(showHmac);
  bool upperCaseData = ref.watch(hashUpperCase);
  String inputData = ref.watch(inputController).text;
  String optionalData = ref.watch(optionalController).text;
  if (inputData.isEmpty) return const [];

  final results = <HashResult>[];
  for (var item in HashType.values) {
    final converter = _Converter(item);
    if (!showHmacData) {
      String normal = converter.convert(inputData).toString();
      if (upperCaseData) normal = normal.toUpperCase();
      results.add(HashResult(type: item, result: normal));
    } else {
      String hmacData =
          converter.convertWithSecret(inputData, optionalData).toString();
      if (upperCaseData) hmacData = hmacData.toUpperCase();
      results.add(HMACResult(type: item, result: hmacData));
    }
  }

  return results;
});

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
