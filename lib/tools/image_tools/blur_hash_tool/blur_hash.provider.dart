import 'dart:io';

import 'package:alga/utils/image_util.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'blur_hash.provider.g.dart';

Future<ImageItem?> _gen(File file) async {
  return await compute(ImageUtil.getBlurHash, file);
}

@riverpod
class ImageFile extends _$ImageFile {
  @override
  XFile? build() => null;

  void change(XFile? file) {
    state = file;
  }

  void clear() {
    state = null;
  }
}

@riverpod
FutureOr<ImageItem?> blurHashText(BlurHashTextRef ref) async {
  final imageFile = ref.watch(imageFileProvider);
  if (imageFile == null) return null;
  return await _gen(File(imageFile.path));
}

// modify from flutter_blurhash
// UNDER MIT
// https://github.com/fluttercommunity/flutter_blurhash/blob/master/LICENSE
(bool, String?) validateBlurHash(String blurHash) {
  if (blurHash.length < 6) {
    return (false, 'The blurhash string must be at least 6 characters');
  }

  final sizeFlag = _decode83(blurHash[0]);
  final numY = (sizeFlag / 9).floor() + 1;
  final numX = (sizeFlag % 9) + 1;

  if (blurHash.length != 4 + 2 * numX * numY) {
    return (
      false,
      'blurhash length mismatch: length is ${blurHash.length} but '
          'it should be ${4 + 2 * numX * numY}'
    );
  }

  return (true, null);
}

int _decode83(String str) {
  var value = 0;
  final units = str.codeUnits;
  final digits = _digitCharacters.codeUnits;
  for (var i = 0; i < units.length; i++) {
    final code = units.elementAt(i);
    final digit = digits.indexOf(code);
    if (digit == -1) {
      throw ArgumentError.value(str, 'str');
    }
    value = value * 83 + digit;
  }
  return value;
}

const _digitCharacters =
    "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz#\$%*+,-.:;=?@[]^_{|}~";
