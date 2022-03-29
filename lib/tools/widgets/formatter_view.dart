import 'package:flutter/services.dart';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/formatters/formatter_abstract.dart';

class FormatterView extends StatefulWidget {
  final Widget title;
  final List<Widget> configs;
  final FormatResult Function(String text) onChanged;
  final String lang;
  const FormatterView(
      {Key? key,
      required this.title,
      required this.configs,
      required this.onChanged,
      required this.lang})
      : super(key: key);

  @override
  State<FormatterView> createState() => FormatterViewState();
}

class FormatterViewState extends State<FormatterView> {
  final _inputController = TextEditingController();
  String outputText = '';

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView(
      title: widget.title,
      content: ToolbarView(
        configs: widget.configs,
        inputWidget: LangTextField(
          lang: widget.lang,
          minLines: 80,
          maxLines: 100,
          controller: _inputController,
          onChanged: (text) {
            outputText = widget.onChanged(text).result;
            setState(() {});
          },
        ),
        outputWidget: AppTextBox(
          lang: widget.lang,
          minLines: 80,
          maxLines: 100,
          data: outputText,
        ),
        inputActions: [
          IconButton(
            icon: const Icon(Icons.paste),
            onPressed: () async {
              final rawText = await Clipboard.getData('text/plain');
              _inputController.text = rawText?.text ?? '';
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _inputController.clear();
              outputText = '';
              setState(() {});
            },
          ),
        ],
        outputActions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: outputText));
            },
          ),
        ],
      ),
    );
  }
}
