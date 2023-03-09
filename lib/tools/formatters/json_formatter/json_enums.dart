import 'package:alga/utils/constants/import_helper.dart';

enum JsonIndentType {
  space2,
  space4,
  tab,
  minified,
}

extension JsonIndentExt on JsonIndentType {
  String name(BuildContext context) {
    switch (this) {
      case JsonIndentType.space2:
        return S.of(context).json2spaces;
      case JsonIndentType.space4:
        return S.of(context).json4spaces;
      case JsonIndentType.tab:
        return S.of(context).json1tab;
      case JsonIndentType.minified:
        return S.of(context).jsonMinified;
    }
  }
}
