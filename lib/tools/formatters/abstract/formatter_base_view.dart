import 'package:alga/widgets/tool_view.dart';
import 'package:flutter/material.dart';
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
    return ToolView(
      title: Text(widget.base.title),
      content: ToolbarView(
        configs: widget.configs,
        inputWidget: TextField(
          minLines: 80,
          maxLines: 100,
          controller: widget.base.inputController,
          onChanged: (text) {
            try {
              widget.base.convertIt();
            } catch (e) {
              return;
            }
          },
        ),
        outputWidget: TextField(
          minLines: 80,
          maxLines: 100,
          controller: widget.base.outputController,
        ),
        inputActions: [
          IconButton(
            icon: const Icon(Icons.paste),
            onPressed: () async {
              final rawText = await Clipboard.getData('text/plain');
              widget.base.inputController.text = rawText?.text ?? '';
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              widget.base.clearAll();
            },
          ),
        ],
        outputActions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(text: widget.base.outputController.text),
              );
            },
          ),
        ],
      ),
    );
  }
}
