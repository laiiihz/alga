import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/formatters/formatter_abstract.dart';
import 'package:flutter/services.dart';
import 'package:language_textfield/language_textfield.dart';


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
  final _outputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView(
      title: widget.title,
      content: ToolbarView(
        configs: widget.configs,
        inputWidget: Material(
          child: LangTextField(
            lang: widget.lang,
            minLines: 80,
            maxLines: 100,
            controller: _inputController,
            onChanged: (text) {
              _outputController.text = widget.onChanged(text).result;
            },
          ),
        ),
        outputWidget: Material(
          child: LangTextField(
            lang: widget.lang,
            minLines: 80,
            maxLines: 100,
            controller: _outputController,
          ),
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
              _outputController.clear();
            },
          ),
        ],
        outputActions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(text: _outputController.text),
              );
            },
          ),
        ],
      ),
    );
  }
}
