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
  final _controller = TextEditingController();
  final _textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ref.read(_regexTextProvider.notifier).update((state) => _controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(context.tr.regexTester),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewSwitchConfig(
              title: const Text('multiLine'),
              value: (ref) => ref.watch(_multiLine),
              onChanged: (value, ref) =>
                  ref.read(_multiLine.notifier).update((state) => value),
            ),
            ToolViewSwitchConfig(
              title: const Text('caseSensitive'),
              value: (ref) => ref.watch(_caseSensitive),
              onChanged: (value, ref) =>
                  ref.read(_caseSensitive.notifier).update((state) => value),
            ),
            ToolViewSwitchConfig(
              title: const Text('unicode'),
              value: (ref) => ref.watch(_unicode),
              onChanged: (value, ref) =>
                  ref.read(_unicode.notifier).update((state) => value),
            ),
            ToolViewSwitchConfig(
              title: const Text('dotAll'),
              value: (ref) => ref.watch(_dotAll),
              onChanged: (value, ref) =>
                  ref.read(_dotAll.notifier).update((state) => value),
            ),
          ],
        ),
        AppTitleWrapper(
          title: context.tr.regularExpression,
          actions: [
            PasteButtonWidget(_controller),
            ClearButtonWidget(_controller),
          ],
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              errorText: ref.watch(_errorProvider),
            ),
          ),
        ),
        AppTitleWrapper(
          title: context.tr.regexText,
          actions: [
            PasteButtonWidget(_textController),
            ClearButtonWidget(_textController),
          ],
          child: ExtendedTextField(
            minLines: 2,
            maxLines: 99,
            controller: _textController,
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
