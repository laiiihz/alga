part of './sass_css_generator_view.dart';

final _inputController = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _inputText =
    Provider.autoDispose((ref) => ref.watch(_inputController).text);

final _compress = StateProvider.autoDispose<bool>((ref) => false);

final _syntax = StateProvider.autoDispose<Syntax>((ref) => Syntax.scss);

final _cssResult = Provider.autoDispose<CompileResult?>((ref) {
  final compress = ref.watch(_compress);
  final text = ref.watch(_inputText);
  final syntax = ref.watch(_syntax);
  try {
    final result = compileStringToResult(
      text,
      style: compress ? OutputStyle.compressed : OutputStyle.expanded,
      syntax: syntax,
    );
    return result;
  } catch (e) {
    return null;
  }
});

final _css =
    Provider.autoDispose<String>((ref) => ref.watch(_cssResult)?.css ?? '');
