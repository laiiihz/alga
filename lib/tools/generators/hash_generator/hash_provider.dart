import 'dart:convert';
import 'dart:typed_data';

import 'package:alga/l10n/l10n.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pointycastle/export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hash_provider.g.dart';

enum HashType {
  md5,
  md4,
  md2,
  ripemd128,
  ripemd160,
  ripemd256,
  ripemd320,
  sha1,
  sha3,
  sha224,
  sha256,
  sha384,
  sha512,
  sha512224,
  sha512256,
  sm3,
  tiger,
  ;

  String typeName(BuildContext context) {
    switch (this) {
      case HashType.md4:
      case HashType.md2:
      case HashType.ripemd128:
      case HashType.ripemd160:
      case HashType.ripemd256:
      case HashType.ripemd320:
      case HashType.sha3:
      case HashType.tiger:
      case HashType.md5:
      case HashType.sha1:
      case HashType.sha224:
      case HashType.sha256:
      case HashType.sha384:
      case HashType.sha512:
        return name;
      case HashType.sha512224:
        return 'sha512/224';
      case HashType.sha512256:
        return 'sha512/256';
      case HashType.sm3:
        return context.tr.hashSM3;
    }
  }

  Digest get _digest {
    switch (this) {
      case HashType.md5:
        return MD5Digest();
      case HashType.sha1:
        return SHA1Digest();
      case HashType.sha3:
        return SHA3Digest();
      case HashType.sha224:
        return SHA224Digest();
      case HashType.sha256:
        return SHA256Digest();
      case HashType.sha384:
        return SHA384Digest();
      case HashType.sha512:
        return SHA512Digest();
      case HashType.sha512224:
        return SHA512tDigest(56);
      case HashType.sha512256:
        return SHA512tDigest(64);
      case HashType.sm3:
        return SM3Digest();
      case HashType.md4:
        return MD4Digest();
      case HashType.md2:
        return MD2Digest();
      case HashType.ripemd128:
        return RIPEMD128Digest();
      case HashType.ripemd160:
        return RIPEMD160Digest();
      case HashType.ripemd256:
        return RIPEMD256Digest();
      case HashType.ripemd320:
        return RIPEMD320Digest();
      case HashType.tiger:
        return TigerDigest();
    }
  }

  Uint8List convert(String data) {
    return _digest.process(Uint8List.fromList(utf8.encode(data)));
  }

  Uint8List _utf8(String data) => utf8.encode(data) as Uint8List;

  Uint8List convertHMAC(String data, String key) {
    final hmac = HMac.withDigest(_digest)..init(KeyParameter(_utf8(key)));
    final result = hmac.process(_utf8(data));
    return result;
  }
}

@riverpod
TextEditingController inputController(InputControllerRef ref) {
  final ctrl = TextEditingController();
  ctrl.addListener(() => ref.invalidate(inputTextProvider));
  ref.onDispose(() => ctrl.dispose());
  return ctrl;
}

@riverpod
String inputText(InputTextRef ref) {
  return ref.watch(inputControllerProvider).text;
}

@riverpod
TextEditingController saltController(SaltControllerRef ref) {
  final ctrl = TextEditingController();
  ctrl.addListener(() => ref.invalidate(saltTextProvider));
  ref.onDispose(() => ctrl.dispose());
  return ctrl;
}

@riverpod
String saltText(SaltTextRef ref) => ref.watch(saltControllerProvider).text;

final hashTypeProvider =
    StateProvider.autoDispose<HashType>((ref) => HashType.md5);

@riverpod
String hashResult(HashResultRef ref) {
  bool showHmacData = ref.watch(showHmac);
  bool upperCaseData = ref.watch(hashUpperCase);
  String inputData = ref.watch(inputTextProvider);
  String saltData = ref.watch(saltTextProvider);
  HashType typeData = ref.watch(hashTypeProvider);
  late String result;
  if (showHmacData) {
    // result = converter.convertWithSecret(inputData, saltData).toString();
    result = hex.encode(typeData.convertHMAC(inputData, saltData));
  } else {
    // result = converter.convert(inputData).toString();
    result = hex.encode(typeData.convert(inputData));
  }

  if (upperCaseData) result = result.toUpperCase();

  return result;
}

final hashUpperCase = StateProvider.autoDispose<bool>((ref) => false);
final showHmac = StateProvider.autoDispose<bool>((ref) => false);
