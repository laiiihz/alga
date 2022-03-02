import 'package:devtoys/tools/generators/hash_generator/hash_provider.dart';
import 'package:devtoys/widgets/app_title.dart';
import 'package:devtoys/widgets/tool_view.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as f_icons;

import '../../../constants/import_helper.dart';
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

  List<Widget> controllers2Widgets(List<HashTypeWrapper> controllers) {
    return controllers.map((e) {
      return AppTitleWrapper(
        title: e.title,
        actions: const [],
        child: Row(
          children: [
            Expanded(child: TextBox(controller: e.controller)),
            const SizedBox(width: 8),
            Button(
              child: const Icon(f_icons.FluentIcons.copy_24_regular),
              onPressed: () {
                e.copy();
              },
            ),
          ],
        ),
      );
    }).toList();
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
        AppTitle(title: S.of(context).configuration),
        ToolViewConfig(
          leading: const Icon(FluentIcons.upper_case),
          title: const Text('UpperCase'),
          trailing: ToggleSwitch(
            checked: _provider.upperCase,
            onChanged: (value) {
              _provider.upperCase = value;
            },
          ),
        ),
        ToolViewConfig(
          title: const Text('HMAC'),
          subtitle: const Text('Keyed-hash message authentication code'),
          trailing: ToggleSwitch(
            checked: _provider.showHmac,
            onChanged: (value) {
              _provider.showHmac = value;
              _provider.generate();
            },
          ),
        ),
        AppTitle(
          title: S.of(context).input,
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
        if (_provider.showHmac)
          TextBox(
            minLines: 12,
            maxLines: 12,
            controller: _provider.optionalController,
            placeholder: 'Optional',
            header: 'secret',
            onChanged: (text) {
              _provider.generate();
            },
          ),
        if (!_provider.showHmac) ...controllers2Widgets(_provider.controllers),
        if (_provider.showHmac)
          ...controllers2Widgets(_provider.hmacControllers),
      ],
    );
  }
}
