import 'dart:convert';

import 'package:devtoys/widgets/toolbar_config.dart';
import 'package:devtoys/widgets/toolbar_view.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

enum JsonIndentType {
  space2,
  space4,
  tab,
  zip,
}

class JsonFormatterView extends StatefulWidget {
  const JsonFormatterView({Key? key}) : super(key: key);

  @override
  State<JsonFormatterView> createState() => _JsonFormatterViewState();
}

class _JsonFormatterViewState extends State<JsonFormatterView> {
  final _editingController = TextEditingController();
  final _resultController = TextEditingController();
  JsonIndentType _type = JsonIndentType.space2;
  String pretty(Map<String, dynamic> jsonMap, JsonIndentType type) {
    String indent = '';
    switch (type) {
      case JsonIndentType.space2:
        indent = ' ' * 2;
        break;
      case JsonIndentType.space4:
        indent = ' ' * 4;
        break;
      case JsonIndentType.tab:
        indent = '\t';
        break;
      default:
        break;
    }
    final encoder = JsonEncoder.withIndent(indent);
    if (type == JsonIndentType.zip) {
      return json.encode(jsonMap).trim();
    }
    return encoder.convert(jsonMap);
  }

  _convert() {
    final _t = DateTime.now();
    Map<String, dynamic> jsonMap = {};
    try {
      jsonMap = json.decode(_editingController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return ContentDialog(
              title: const Text('JSON decode Error'),
              content: Text(e.toString()),
              actions: [
                Button(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
      return;
    }
    _resultController.text = pretty(jsonMap, _type);
  }

  @override
  void dispose() {
    _editingController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(
        title: Text('JSON formatter'),
      ),
      content: ToolbarView(
        configs: [
          ToolbarConfig(
            title: '缩进',
            trailing: Combobox<JsonIndentType>(
              value: _type,
              items: JsonIndentType.values
                  .map(
                    (e) => ComboboxItem(child: Text(e.toString()), value: e),
                  )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  _type = item ?? JsonIndentType.space2;
                });
              },
            ),
          ),
        ],
        inputWidget: TextBox(
          minLines: 80,
          maxLines: 100,
          controller: _editingController,
        ),
        outputWidget: TextBox(
          minLines: 80,
          maxLines: 100,
          controller: _resultController,
        ),
        inputActions: [
          Button(
            child: const Text('paste'),
            onPressed: () async {
              final rawText = await Clipboard.getData('text/plain');
              _editingController.text = rawText?.text ?? '';
            },
          ),
          Button(
            child: const Text('clear'),
            onPressed: () {
              _editingController.clear();
              _resultController.clear();
            },
          ),
        ],
        outputActions: [
          Button(
            child: const Text('copy'),
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(text: _resultController.text),
              );
              showDialog(
                  context: context,
                  builder: (context) {
                    return ContentDialog(
                      title: const Text('Copied !'),
                      actions: [
                        Button(
                          child: const Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
        midWidgets: [
          Button(
            child: const Text('convert'),
            onPressed: _convert,
          )
        ],
      ),
    );
  }
}
