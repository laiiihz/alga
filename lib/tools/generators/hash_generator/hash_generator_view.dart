import 'package:devtoys/tools/generators/hash_generator/hash_provider.dart';
import 'package:devtoys/widgets/app_title.dart';
import 'package:devtoys/widgets/tool_view.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../widgets/tool_view_config.dart';

class HashGeneratorView extends StatefulWidget {
  const HashGeneratorView({Key? key}) : super(key: key);

  @override
  State<HashGeneratorView> createState() => _HashGeneratorViewState();
}

class _HashGeneratorViewState extends State<HashGeneratorView> {
  final _provider = HashProvider();

  update() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _provider.addListener(update);
  }

  @override
  void dispose() {
    _provider.removeListener(update);
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: const Text('Hash Genergator'),
      children: [
        const AppTitle(title: 'Config'),
        ToolViewConfig(
          title: const Text('UpperCase'),
          trailing: ToggleSwitch(
            checked: _provider.upperCase,
            onChanged: (value) {
              _provider.upperCase = value;
            },
          ),
        ),
        AppTitle(
          title: 'Input',
          actions: [
            Button(
              child: const Icon(FluentIcons.paste),
              onPressed: () {
                _provider.setInputFormClipboard();
              },
            ),
            Button(
              child: const Icon(FluentIcons.clear),
              onPressed: () {
                _provider.inputController.clear();
              },
            ),
          ],
        ),
        TextBox(
          minLines: 12,
          maxLines: 12,
          controller: _provider.inputController,
          onChanged: (text) {
            _provider.generate();
          },
        ),
        ..._provider.controllers.map((e) {
          return AppTitleWrapper(
            title: e.title,
            actions: const [],
            child: Row(
              children: [
                Expanded(child: TextBox(controller: e.controller)),
                const SizedBox(width: 8),
                Button(
                  child: const Icon(FluentIcons.copy),
                  onPressed: () {
                    e.copy();
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
