import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_textfield/json_textfield.dart';
import 'dart:convert';

import 'package:json2yaml/json2yaml.dart' as json_2_yaml;
import 'package:yaml/yaml.dart';

part './json_yaml_converter_provider.dart';

class JsonYamlConverterView extends ConsumerWidget {
  const JsonYamlConverterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jsonWidget = AppTitleWrapper(
      title: 'JSON',
      expand: !isSmallDevice(context),
      actions: [
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            ClipboardUtil.copy(ref.read(_jsonController).text);
          },
        ),
        IconButton(
          icon: const Icon(Icons.paste),
          onPressed: () async {
            ref.read(_jsonController).text = await ClipboardUtil.paste();
          },
        ),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: ref.read(_jsonController).clear,
        ),
      ],
      child: JsonTextField(
        minLines: isSmallDevice(context) ? 12 : null,
        maxLines: isSmallDevice(context) ? 12 : null,
        controller: ref.watch(_jsonController),
        onChanged: (_) {
          JsonYamlUtil.json2yaml(ref);
        },
        expands: !isSmallDevice(context),
      ),
    );
    final yamlWidget = AppTitleWrapper(
      title: 'YAML',
      expand: !isSmallDevice(context),
      actions: [
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            ClipboardUtil.copy(ref.read(_yamlController).text);
          },
        ),
        IconButton(
          icon: const Icon(Icons.paste),
          onPressed: () async {
            ref.read(_yamlController).text = await ClipboardUtil.paste();
          },
        ),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: ref.read(_yamlController).clear,
        ),
      ],
      child: LangTextField(
        minLines: isSmallDevice(context) ? 12 : null,
        maxLines: isSmallDevice(context) ? 12 : null,
        expands: !isSmallDevice(context),
        controller: ref.watch(_yamlController),
        onChanged: (_) {
          JsonYamlUtil.yaml2json(ref);
        },
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
