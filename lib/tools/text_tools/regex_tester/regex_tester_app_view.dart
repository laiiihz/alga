import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/tools/text_tools/regex_tester/regex_tester_provider.dart';
import 'package:alga/ui/widgets/clear_button_widget.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';

class RegexTestAppRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegexTestAppView();
  }
}

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
              value: regexMultiLine,
            ),
            AlgaConfigSwitch(
              title: Text(context.tr.regexCaseSensitive),
              value: regexCaseSensitive,
            ),
            AlgaConfigSwitch(
              title: Text(context.tr.regexUnicode),
              value: regexUnicode,
            ),
            AlgaConfigSwitch(
              title: Text(context.tr.regexDotAll),
              value: regexDotAll,
            ),
          ],
        ),
        AppTitleWrapper(
          title: context.tr.regularExpression,
          actions: [
            PasteButtonWidget(regexExpressionProvider),
            ClearButtonWidget(regexExpressionProvider),
          ],
          child: Consumer(
            builder: (context, ref, _) {
              final value = ref.watch(regexValueProvider);
              return TextField(
                controller: ref.watch(regexExpressionProvider),
                decoration: InputDecoration(
                  errorText: value.hasError ? value.error!.message : null,
                ),
              );
            },
          ),
        ),
        AppTitleWrapper(
          title: context.tr.regexText,
          actions: [
            PasteButtonWidget(regexInputControllerProvider),
            ClearButtonWidget(regexInputControllerProvider),
          ],
          child: TextField(
            minLines: 2,
            maxLines: 99,
            controller: ref.watch(regexInputControllerProvider),
          ),
        ),
      ],
    );
  }
}
