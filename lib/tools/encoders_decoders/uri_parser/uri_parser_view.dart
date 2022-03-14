import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/encoders_decoders/uri_parser/uri_parser_provider.dart';
import 'package:alga/utils/clipboard_util.dart';

class UriParserView extends StatefulWidget {
  const UriParserView({Key? key}) : super(key: key);

  @override
  State<UriParserView> createState() => _UriParserViewState();
}

class _UriParserViewState extends State<UriParserView> {
  final _provider = UriParserProvider();
  update() {
    setState(() {});
  }

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
      title: const Text('URI Parser'),
      children: [
        AppTitleWrapper(
          title: 'source',
          actions: [
            IconButton(
              onPressed: () {
                _provider.paste();
              },
              icon: const Icon(Icons.paste),
            ),
          ],
          child: LangTextField(
            lang: LangHighlightType.uri,
            controller: _provider.inputController,
            onChanged: (_) {
              _provider.parse();
            },
          ),
        ),
        ..._provider.parts.map((e) {
          return AppTitleWrapper(
            title: e.title,
            actions: [
              IconButton(
                onPressed: () {
                  ClipboardUtil.copy(e.name());
                },
                icon: const Icon(Icons.copy),
              ),
            ],
            child: AppTextBox(
              data: e.name(),
              lang: e.lang,
            ),
          );
        }).toList(),
      ],
    );
  }
}
