import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/text_tools/regex_tester/regex_tester_provider.dart';
import 'package:alga/tools/text_tools/regex_tester/regex_tester_text_builder.dart';
import 'package:extended_text_field/extended_text_field.dart';

class RegexTesterView extends StatefulWidget {
  const RegexTesterView({Key? key}) : super(key: key);

  @override
  State<RegexTesterView> createState() => _RegexTesterViewState();
}

class _RegexTesterViewState extends State<RegexTesterView> {
  final _provider = RegexTesterProvider();

  update() => setState(() {});

  @override
  void initState() {
    super.initState();
    _provider.addListener(update);
  }

  @override
  void dispose() {
    _provider.removeListener(update);
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).regexTester),
      children: [
        AppTitleWrapper(
          title: S.of(context).regularExpression,
          actions: [
            IconButton(
              icon: const Icon(Icons.paste),
              onPressed: _provider.pasteReg,
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _provider.clearReg,
            ),
          ],
          child: TextField(
            controller: _provider.regexController,
            onChanged: (_) {
              _provider.update();
            },
          ),
        ),
        AppTitleWrapper(
          title: S.of(context).regexText,
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: _provider.pasteText,
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _provider.clearText,
            ),
          ],
          child: ExtendedTextField(
            controller: _provider.textController,
            minLines: 2,
            maxLines: 16,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            specialTextSpanBuilder: RegexTesterTextBuilder(_provider),
          ),
        ),
      ],
    );
  }
}
