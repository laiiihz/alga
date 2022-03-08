import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/converters/json_yaml_converter/json_yaml_converter_provider.dart';
import 'package:flutter/material.dart';
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
    return ToolView.scrollVertical(
      title: Text(S.of(context).jsonYamlConverter),
      children: [
        Row(
          children: [
            Expanded(
              child: AppTitleWrapper(
                title: 'JSON',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: _provider.copyJson,
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.paste),
                    onPressed: _provider.pasteJson,
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.clear),
                    onPressed: _provider.clear,
                  ),
                ],
                child: Material(
                  child: JsonTextField(
                    minLines: 12,
                    maxLines: 12,
                    controller: _provider.jsonController,
                    onChanged: (_) {
                      _provider.json2yaml();
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTitleWrapper(
                title: 'YAML',
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
                child: Material(
                  child: LangTextField(
                    minLines: 12,
                    maxLines: 12,
                    controller: _provider.yamlController,
                    onChanged: (_) {
                      _provider.yaml2json();
                    },
                    lang: 'yaml',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
