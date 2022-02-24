enum JsonIndentType {
  space2,
  space4,
  tab,
  zip,
}

extension JsonIndentExt on JsonIndentType {
  String get name {
    switch (this) {
      case JsonIndentType.space2:
        return '2'.padRight(8);
      case JsonIndentType.space4:
        return '4'.padRight(8);
      case JsonIndentType.tab:
        return 'tab'.padRight(8);
      case JsonIndentType.zip:
        return 'zip'.padRight(8);
    }
  }
}
