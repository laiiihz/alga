import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/encoders_decoders/uri_parser/uri_parser_provider.dart';

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
          actions: const [],
          child: AppTextField(
            controller: _provider.inputController,
            onChanged: (_) {
              _provider.parse();
            },
          ),
        ),
        ListTile(
          title: const Text('host'),
          subtitle: Text(_provider.uri?.host ?? ''),
        ),
        ListTile(
          title: const Text('origin'),
          subtitle: Text(_provider.uri?.origin ?? ''),
        ),
      ],
    );
  }
}
