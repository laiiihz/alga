part of './sass_css_generator_view.dart';

final _inputController = StateProvider.autoDispose<TextEditingController>(
    (ref) => TextEditingController());

final _compress = StateProvider.autoDispose<bool>((ref) => false);

final _syntax = StateProvider.autoDispose<Syntax>((ref) => Syntax.scss);

final _cssResult = StateProvider.autoDispose<String>((ref) {
  final compress = ref.watch(_compress);
  final text = ref.watch(_inputController).text;
  final syntax = ref.watch(_syntax);
  try {
    final result = compileStringToResult(
      text,
      style: compress ? OutputStyle.compressed : OutputStyle.expanded,
      syntax: syntax,
    );
    return result.css;
  } catch (e) {
    return '';
  }
});
