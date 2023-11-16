import 'dart:convert';
import 'dart:typed_data';

import 'package:alga/tools/generators/hash_generator/hash_gen.dart';
import 'package:alga/utils/constants/import_helper.dart';
import 'package:convert/convert.dart';
import 'package:pointycastle/export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'hash_gen.provider.g.dart';

enum HashAlg {
  md5,
  blake2b,
  keccak,
  md2,
  md4,
  ripemd128,
  ripemd160,
  ripemd256,
  ripemd320,
  sha1,
  sha3_224,
  sha3_256,
  sha3_384,
  sha3_512,
  sha224,
  sha256,
  sha384,
  sha512,
  sha512_224,
  sha512_256,
  shake128,
  shake256,
  sm3,
  tiger,
  whirlpool,
  ;

  String getName(BuildContext context) {
    if (this == sm3) return context.tr.hashSM3;
    return name.replaceAll('_', '/');
  }

  Digest get digest {
    return switch (this) {
      md5 => MD5Digest(),
      blake2b => Blake2bDigest(),
      keccak => KeccakDigest(),
      md2 => MD2Digest(),
      md4 => MD4Digest(),
      ripemd128 => RIPEMD128Digest(),
      ripemd160 => RIPEMD160Digest(),
      ripemd256 => RIPEMD256Digest(),
      ripemd320 => RIPEMD320Digest(),
      sha1 => SHA1Digest(),
      sha3_224 => SHA3Digest(224),
      sha3_256 => SHA3Digest(256),
      sha3_384 => SHA3Digest(384),
      sha3_512 => SHA3Digest(512),
      sha224 => SHA224Digest(),
      sha256 => SHA256Digest(),
      sha384 => SHA384Digest(),
      sha512 => SHA512Digest(),
      sha512_224 => SHA512tDigest(56),
      sha512_256 => SHA512tDigest(64),
      shake128 => SHAKEDigest(128),
      shake256 => SHAKEDigest(),
      sm3 => SM3Digest(),
      tiger => TigerDigest(),
      whirlpool => WhirlpoolDigest(),
    };
  }

  Uint8List _utf8(String data) => Uint8List.fromList(utf8.encode(data));

  Uint8List convert(String data) {
    return digest.process(_utf8(data));
  }

  Uint8List convertHmac(String data, String salt) {
    final hmac = HMac.withDigest(digest)..init(KeyParameter(_utf8(salt)));
    return hmac.process(_utf8(data));
  }
}

@riverpod
class HashAlgorithm extends _$HashAlgorithm {
  @override
  HashAlg build() => HashAlg.md5;

  void change(HashAlg next) {
    state = next;
  }
}

@riverpod
String results(ResultsRef ref) {
  final content = ref.watch(useContent);
  if (content.isEmpty) return '';

  final hmac = ref.watch(useHmac);
  final alg = ref.watch(hashAlgorithmProvider);
  late Uint8List bytes;
  if (hmac) {
    final salt = ref.watch(useHmacContent);
    bytes = alg.convertHmac(content, salt);
  } else {
    bytes = alg.convert(content);
  }
  String next = hex.encode(bytes);
  final uppercase = ref.watch(useUpperCase);
  if (uppercase) {
    next = next.toUpperCase();
  }
  return next;
}
