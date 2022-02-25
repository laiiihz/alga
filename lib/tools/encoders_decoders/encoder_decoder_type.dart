enum EncodeDecodeType {
  encode,
  decode,
}

extension EncodeDecodeTypeExt on EncodeDecodeType {
  String get value {
    switch (this) {
      case EncodeDecodeType.encode:
        return 'encode'.padRight(8);
      case EncodeDecodeType.decode:
        return 'decode'.padRight(8);
    }
  }
}
