import 'package:devtoys/constants/import_helper.dart';
import 'package:devtoys/tools/text_tools/regex_tester/regex_tester_provider.dart';
import 'package:devtoys/tools/text_tools/regex_tester/regex_tester_text_builder.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart' as md;

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
      title: const Text('Regex Tester'),
      children: [
        AppTitleWrapper(
          title: 'Regular expression',
          actions: [
            Button(
              child: const Icon(FluentIcons.paste),
              onPressed: _provider.pasteReg,
            ),
            Button(
              child: const Icon(FluentIcons.clear),
              onPressed: _provider.clearReg,
            ),
          ],
          child: TextBox(
            controller: _provider.regexController,
            onChanged: (_) {
              _provider.update();
            },
          ),
        ),
        AppTitleWrapper(
          title: 'Text',
          actions: [
            Button(
              child: const Icon(FluentIcons.copy),
              onPressed: _provider.pasteText,
            ),
            Button(
              child: const Icon(FluentIcons.clear),
              onPressed: _provider.clearText,
            ),
          ],
          child: md.Material(
            child: ExtendedTextField(
              controller: _provider.textController,
              minLines: 16,
              maxLines: 16,
              specialTextSpanBuilder: RegexTesterTextBuilder(_provider),
            ),
          ),
        ),
      ],
    );
  }
}
