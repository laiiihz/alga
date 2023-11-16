import 'package:alga/tools/generators/sass_css_generator/sass2css.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sass/sass.dart';

part 'sass2css.provider.g.dart';

@riverpod
class InputType extends _$InputType {
  @override
  Syntax build() => Syntax.scss;

  void change(Syntax type) {
    state = type;
  }
}

@riverpod
(String, String?) results(ResultsRef ref) {
  final content = ref.watch(useInput);
  final compress = ref.watch(useCompress);
  final type = ref.watch(inputTypeProvider);
  if (content.isEmpty) return ('', null);
  try {
    final result = compileStringToResult(
      content,
      style: compress ? OutputStyle.compressed : OutputStyle.expanded,
      syntax: type,
    );
    return (result.css, null);
  } catch (e) {
    return ('', e.toString());
  }
}
