import 'package:devtoys/constants/import_helper.dart';
import 'package:devtoys/tools/converters/json_yaml_converter/json_yaml_converter_provider.dart';

class JsonYamlConverterView extends StatefulWidget {
  const JsonYamlConverterView({Key? key}) : super(key: key);

  @override
  State<JsonYamlConverterView> createState() => _JsonYamlConverterViewState();
}

class _JsonYamlConverterViewState extends State<JsonYamlConverterView> {
  final _provider = JsonYamlConverterProvider();
  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: const Text("JSON <> YAML Converter"),
      children: [
        Row(
          children: [
            Expanded(
              child: AppTitleWrapper(
                title: 'JSON',
                actions: [
                  Button(
                    child: const Icon(FluentIcons.copy),
                    onPressed: _provider.copyJson,
                  ),
                  Button(
                    child: const Icon(FluentIcons.paste),
                    onPressed: _provider.pasteJson,
                  ),
                  Button(
                    child: const Icon(FluentIcons.clear),
                    onPressed: _provider.clear,
                  ),
                ],
                child: TextBox(
                  minLines: 12,
                  maxLines: 12,
                  controller: _provider.jsonController,
                  onChanged: (_) {
                    _provider.json2yaml();
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTitleWrapper(
                title: 'YAML',
                actions: [
                  Button(
                    child: const Icon(FluentIcons.copy),
                    onPressed: _provider.copyYaml,
                  ),
                  Button(
                    child: const Icon(FluentIcons.paste),
                    onPressed: _provider.pasteYaml,
                  ),
                  Button(
                    child: const Icon(FluentIcons.clear),
                    onPressed: _provider.clear,
                  ),
                ],
                child: TextBox(
                  minLines: 12,
                  maxLines: 12,
                  controller: _provider.yamlController,
                  onChanged: (_) {
                    _provider.yaml2json();
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
