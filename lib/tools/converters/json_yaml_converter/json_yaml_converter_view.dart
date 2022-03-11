import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/converters/json_yaml_converter/json_yaml_converter_provider.dart';
import 'package:json_textfield/json_textfield.dart';
import 'package:language_textfield/language_textfield.dart';

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
    final jsonWidget = AppTitleWrapper(
      title: 'JSON',
      expand: !isSmallDevice(context),
      actions: [
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: _provider.copyJson,
        ),
        IconButton(
          icon: const Icon(Icons.paste),
          onPressed: _provider.pasteJson,
        ),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: _provider.clear,
        ),
      ],
      child: JsonTextField(
        minLines: isSmallDevice(context) ? 12 : null,
        maxLines: isSmallDevice(context) ? 12 : null,
        controller: _provider.jsonController,
        onChanged: (_) {
          _provider.json2yaml();
        },
        expands: !isSmallDevice(context),
        inputDecoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
    final yamlWidget = AppTitleWrapper(
      title: 'YAML',
      expand: !isSmallDevice(context),
      actions: [
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: _provider.copyYaml,
        ),
        IconButton(
          icon: const Icon(Icons.paste),
          onPressed: _provider.pasteYaml,
        ),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: _provider.clear,
        ),
      ],
      child: LangTextField(
        minLines: isSmallDevice(context) ? 12 : null,
        maxLines: isSmallDevice(context) ? 12 : null,
        expands: !isSmallDevice(context),
        controller: _provider.yamlController,
        onChanged: (_) {
          _provider.yaml2json();
        },
        inputDecoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        lang: LangHighlightType.yaml,
      ),
    );
    if (isSmallDevice(context)) {
      return ToolView.scrollVertical(
        title: Text(S.of(context).jsonYamlConverter),
        children: [jsonWidget, yamlWidget],
      );
    } else {
      return ToolView(
        title: Text(S.of(context).jsonYamlConverter),
        content: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(child: jsonWidget),
              const SizedBox(width: 8),
              Expanded(child: yamlWidget),
            ],
          ),
        ),
      );
    }
  }
}
