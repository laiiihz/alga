import 'package:alga/tools/text_tools/regex_tester/regex_tester.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'regex_tester.provider.g.dart';

@riverpod
(RegExp?, String?) regexCheck(RegexCheckRef ref) {
  final content = ref.watch(useRegex);
  if (content.isEmpty) return (null, null);

  try {
    return (
      RegExp(
        content,
        multiLine: ref.watch(useMultiline),
        caseSensitive: ref.watch(useCaseSensitive),
        unicode: ref.watch(useUnicode),
        dotAll: ref.watch(useDotAll),
      ),
      null,
    );
  } on FormatException catch (e) {
    return (null, e.message);
  } catch (e) {
    return (null, e.toString());
  }
}
