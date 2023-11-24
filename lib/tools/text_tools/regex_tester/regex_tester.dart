import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/text_tools/regex_tester/regex_tester.provider.dart';
import 'package:alga/tools/text_tools/regex_tester/regex_tester_text_builder.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/buttons/clear_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:language_textfield/lang_special_builder.dart';
import 'package:language_textfield/language_textfield.dart';

final useMultiline = booleanConfigProvider(const Key('multiline'));
final useCaseSensitive =
    booleanConfigProvider(const Key('caseSensitive'), defaultValue: true);
final useUnicode = booleanConfigProvider(const Key('unicode'));
final useDotAll = booleanConfigProvider(const Key('dotAll'));
final useRegex = stringConfigProvider(const Key('regex'));

class RegexTesterRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegexTesterPage();
  }
}

class RegexTesterPage extends ConsumerStatefulWidget {
  const RegexTesterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegexTesterPageState();
}

class _RegexTesterPageState extends ConsumerState<RegexTesterPage> {
  final RichTextController _regexController =
      RichTextController(builder: LanguageBuilder.regex);

  final RichTextController _textController = RichTextController();
  @override
  void initState() {
    super.initState();
    _regexController.addListener(() {
      ref.read(useRegex.notifier).change(_regexController.text);
    });
  }

  @override
  void dispose() {
    _regexController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final finalRegex = ref.watch(regexCheckProvider);
    if (finalRegex.$1 != null) {
      _textController.updateBuilder(RegexTesterBuilder(finalRegex.$1));
    }
    return ScrollableScaffold(
      title: Text(context.tr.regexTester),
      configurations: [
        ConfigSwitch(
          title: Text(context.tr.regexMultiLine),
          value: useMultiline,
        ),
        ConfigSwitch(
          title: Text(context.tr.regexCaseSensitive),
          value: useCaseSensitive,
        ),
        ConfigSwitch(
          title: Text(context.tr.regexUnicode),
          value: useUnicode,
        ),
        ConfigSwitch(
          title: Text(context.tr.regexDotAll),
          value: useDotAll,
        )
      ],
      children: [
        AlgaToolbar(
          title: Text(context.tr.regularExpression),
          actions: [
            PasteButton(controller: _regexController),
            ClearButton(controller: _regexController),
          ],
        ),
        TextField(
          minLines: 2,
          maxLines: 4,
          controller: _regexController,
          decoration: InputDecoration(errorText: finalRegex.$2),
        ),
        AlgaToolbar(
          title: Text(context.tr.regexText),
          actions: [
            PasteButton(controller: _textController),
            ClearButton(controller: _textController),
          ],
        ),
        TextField(
          minLines: 2,
          maxLines: 12,
          controller: _textController,
        ),
      ],
    );
  }
}
