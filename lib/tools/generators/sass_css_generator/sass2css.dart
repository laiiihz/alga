import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/generators/sass_css_generator/sass2css.provider.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/buttons/clear_button.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:language_textfield/lang_special_builder.dart';
import 'package:language_textfield/language_textfield.dart';
import 'package:sass/sass.dart';

final useCompress = booleanConfigProvider(const ValueKey('compress'));
final useInput = stringConfigProvider(const ValueKey('input'));

class Sass2cssRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Sass2cssPage();
  }
}

class Sass2cssPage extends ConsumerStatefulWidget {
  const Sass2cssPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Sass2cssPageState();
}

class _Sass2cssPageState extends ConsumerState<Sass2cssPage> {
  final _input = RichTextController.lang(type: HighlightType.scss);
  @override
  void initState() {
    super.initState();
    _input.addListener(() {
      ref.read(useInput.notifier).change(_input.text);
    });
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(resultsProvider);
    return ScrollableScaffold(
      title: Text(context.tr.sassCssGenerator),
      configurations: [
        ConfigSwitch(
          leading: const Icon(Icons.compress),
          title: Text(context.tr.compress),
          value: useCompress,
        ),
        ConfigMenu<Syntax>(
          leading: const Icon(Icons.type_specimen_rounded),
          items: Syntax.values,
          getName: (type) => type.name,
          title: Text(context.tr.sassSourceType),
          initItem: ref.watch(inputTypeProvider),
          onSelect: (t) {
            ref.read(inputTypeProvider.notifier).change(t);
            switch (t) {
              case Syntax.scss:
              case Syntax.sass:
                _input.updateBuilder(
                    LanguageBuilder.highlight(HighlightType.scss));
              case Syntax.css:
                _input.updateBuilder(
                    LanguageBuilder.highlight(HighlightType.css));
            }
          },
        ),
      ],
      children: [
        AlgaToolbar(
          title: Text(context.tr.input),
          actions: [
            PasteButton(controller: _input),
            ClearButton(controller: _input),
          ],
        ),
        Consumer(
          builder: (context, ref, _) {
            return AppInput(
              minLines: 3,
              maxLines: 8,
              controller: _input,
              decoration: InputDecoration(errorText: results.$2),
            );
          },
        ),
        AlgaToolbar(
          actions: [
            CopyButton(() => results.$1),
          ],
        ),
        AppTextField(
          text: results.$1,
          language: HighlightType.css,
        ),
      ],
    );
  }
}
