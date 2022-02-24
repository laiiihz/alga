import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

import '../../../widgets/toolbar_view.dart';
import 'formatter_base.dart';

class FormatterBaseView<T extends FormatterBase> extends StatefulWidget {
  final T base;
  final List<Widget> configs;
  const FormatterBaseView({Key? key, required this.base, required this.configs})
      : super(key: key);

  @override
  State<FormatterBaseView> createState() => _FormatterBaseViewState();
}

class _FormatterBaseViewState extends State<FormatterBaseView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.base.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(
        title: Text('JSON formatter'),
      ),
      content: ToolbarView(
        configs: widget.configs,
        inputWidget: TextBox(
          minLines: 80,
          maxLines: 100,
          controller: widget.base.inputController,
          onChanged: (text) {
            try {
              widget.base.convertIt();
            } catch (e) {}
          },
        ),
        outputWidget: TextBox(
          minLines: 80,
          maxLines: 100,
          controller: widget.base.outputController,
        ),
        inputActions: [
          Button(
            child: const Text('paste'),
            onPressed: () async {
              final rawText = await Clipboard.getData('text/plain');
              widget.base.inputController.text = rawText?.text ?? '';
            },
          ),
          Button(
            child: const Text('clear'),
            onPressed: () {
              widget.base.clearAll();
            },
          ),
        ],
        outputActions: [
          Button(
            child: const Text('copy'),
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(text: widget.base.outputController.text),
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
