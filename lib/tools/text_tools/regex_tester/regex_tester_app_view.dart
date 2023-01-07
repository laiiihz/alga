import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/text_tools/regex_tester/regex_tester_text_builder.dart';
import 'package:alga/widgets/clear_button_widget.dart';
import 'package:alga/widgets/paste_button_widget.dart';
import 'package:extended_text_field/extended_text_field.dart';
part './regex_tester_app_provider.dart';

class RegexTestAppView extends ConsumerStatefulWidget {
  const RegexTestAppView({super.key});

  @override
  ConsumerState<RegexTestAppView> createState() => _RegexTestAppViewState();
}

class _RegexTestAppViewState extends ConsumerState<RegexTestAppView> {
  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(context.tr.regexTester),
      children: [
        ToolViewWrapper(
          children: [
            AlgaConfigSwitch(
              title: Text(context.tr.regexMultiLine),
              value: _multiLine,
            ),
            AlgaConfigSwitch(
              title: Text(context.tr.regexCaseSensitive),
              value: _caseSensitive,
            ),
            AlgaConfigSwitch(
              title: Text(context.tr.regexUnicode),
              value: _unicode,
            ),
            AlgaConfigSwitch(
              title: Text(context.tr.regexDotAll),
              value: _dotAll,
            ),
          ],
        ),
        AppTitleWrapper(
          title: context.tr.regularExpression,
          actions: [
            PasteButtonWidget(
              _regexTextProvider,
              onUpdate: (ref) => ref.refresh(_regexText),
            ),
            ClearButtonWidget(
              _regexTextProvider,
              onUpdate: (ref) => ref.refresh(_regexText),
            ),
          ],
          child: TextField(
            controller: ref.watch(_regexTextProvider),
            decoration: InputDecoration(
              errorText: ref.watch(_errorProvider),
            ),
            onChanged: (value) => ref.refresh(_regexText),
          ),
        ),
        AppTitleWrapper(
          title: context.tr.regexText,
          actions: [
            PasteButtonWidget(
              _resultControllerProvider,
              onUpdate: (ref) => ref.refresh(_regexProvider),
            ),
            ClearButtonWidget(
              _resultControllerProvider,
              onUpdate: (ref) => ref.refresh(_regexProvider),
            ),
          ],
          child: ExtendedTextField(
            minLines: 2,
            maxLines: 99,
            controller: ref.watch(_resultControllerProvider),
            onChanged: (value) => ref.refresh(_regexProvider),
            specialTextSpanBuilder: RegexTesterTextBuilder(
              ref.watch(_regexProvider),
              primaryColor: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
