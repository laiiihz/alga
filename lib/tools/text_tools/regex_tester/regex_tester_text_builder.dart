import 'package:alga/tools/text_tools/regex_tester/regex_tester_provider.dart';
import 'package:extended_text_field/extended_text_field.dart';

import 'package:alga/constants/import_helper.dart';

class RegexTesterTextBuilder extends SpecialTextSpanBuilder {
  final RegexTesterProvider provider;
  RegexTesterTextBuilder(this.provider);
  @override
  TextSpan build(String data,
      {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
    if (data.isEmpty) return const TextSpan(text: '');
    if (provider.reg == null) return TextSpan(text: data);

    String cacheData = data;
    final _spans = <InlineSpan>[];

    RegExpMatch? currentMatch = provider.reg!.firstMatch(cacheData);

    while (currentMatch != null) {
      _spans.add(TextSpan(text: cacheData.substring(0, currentMatch.start)));
      _spans.add(TextSpan(
        text: cacheData.substring(
          currentMatch.start,
          currentMatch.end,
        ),
        style: TextStyle(backgroundColor: Colors.blue),
      ));
      if (currentMatch.end <= cacheData.length) {
        cacheData = cacheData.substring(currentMatch.end);
      }
      currentMatch = provider.reg!.firstMatch(cacheData);
    }
    _spans.add(TextSpan(text: cacheData));

    return TextSpan(children: _spans);
  }

  matched() {}

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      required int index}) {
    return null;
  }
}
