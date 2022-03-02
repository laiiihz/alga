enum JsonIndentType {
  space2,
  space4,
  tab,
  minified,
}

extension JsonIndentExt on JsonIndentType {
  String get name {
    switch (this) {
      case JsonIndentType.space2:
        return '2 spaces'.padRight(10);
      case JsonIndentType.space4:
        return '4 spaces'.padRight(10);
      case JsonIndentType.tab:
        return '1 tab'.padRight(10);
      case JsonIndentType.minified:
        return 'minified'.padRight(10);
    }
  }
}
