import 'package:devtoys/tools/formatters/formatter_abstract.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

import '../../../widgets/toolbar_view.dart';

class FormatterView extends StatefulWidget {
  final Widget title;
  final List<Widget> configs;
  final FormatResult Function(String text) onChanged;
  const FormatterView(
      {Key? key,
      required this.title,
      required this.configs,
      required this.onChanged})
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
    return ScaffoldPage.withPadding(
      header: PageHeader(title: widget.title),
      content: ToolbarView(
        configs: widget.configs,
        inputWidget: TextBox(
          minLines: 80,
          maxLines: 100,
          controller: _inputController,
          onChanged: (text) {
            _outputController.text = widget.onChanged(text).result;
          },
        ),
        outputWidget: TextBox(
          minLines: 80,
          maxLines: 100,
          controller: _outputController,
        ),
        inputActions: [
          Button(
            child: const Text('paste'),
            onPressed: () async {
              final rawText = await Clipboard.getData('text/plain');
              _inputController.text = rawText?.text ?? '';
            },
          ),
          Button(
            child: const Text('clear'),
            onPressed: () {
              _inputController.clear();
              _outputController.clear();
            },
          ),
        ],
        outputActions: [
          Button(
            child: const Text('copy'),
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(text: _outputController.text),
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
      ),
    );
  }
}
