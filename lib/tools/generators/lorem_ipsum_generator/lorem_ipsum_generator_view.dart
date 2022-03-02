import 'package:devtoys/constants/import_helper.dart';
import 'package:devtoys/tools/generators/lorem_ipsum_generator/lorem_ipsum_provider.dart';
import 'package:devtoys/widgets/app_title.dart';
import 'package:devtoys/widgets/tool_view.dart';
import 'package:devtoys/widgets/tool_view_config.dart';
import 'package:flutter/services.dart';

class LoremIpsumGeneratorView extends StatefulWidget {
  const LoremIpsumGeneratorView({Key? key}) : super(key: key);

  @override
  State<LoremIpsumGeneratorView> createState() =>
      _LoremIpsumGeneratorViewState();
}

class _LoremIpsumGeneratorViewState extends State<LoremIpsumGeneratorView> {
  final LoremIpsumProvider _provider = LoremIpsumProvider();

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
      title: Text(S.of(context).generatorLoremIpsum),
      children: [
        AppTitle(title: S.of(context).configuration),
        ToolViewConfig(
          leading: const Icon(FluentIcons.text_document),
          title: const Text('Type'),
          subtitle: const Text(
              'Generate words,sentences or paragraphs of Lorem ipsum'),
          trailing: Combobox(
            items: LoremIpsumType.values
                .map((e) => ComboboxItem(child: Text(e.value), value: e))
                .toList(),
            value: _provider.type,
            onChanged: (LoremIpsumType? type) {
              _provider.type = type ?? LoremIpsumType.paragraphs;
              _provider.generate();
            },
          ),
        ),
        ToolViewConfig(
          leading: const Icon(FluentIcons.number_symbol),
          title: const Text('Length'),
          subtitle:
              const Text('Number of words,sentences or paragraphs to generate'),
          trailing: SizedBox(
            width: 60,
            child: TextBox(
              placeholder: '1',
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (text) {
                final value = int.tryParse(text);
                _provider.count = value ?? 1;
                _provider.generate();
              },
            ),
          ),
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            Button(
              child: const Icon(FluentIcons.copy),
              onPressed: () => _provider.copy(),
            ),
            Button(
              child: const Icon(FluentIcons.clear),
              onPressed: () => _provider.clear(),
            ),
          ],
          child: TextBox(
            controller: _provider.outputController,
            minLines: 12,
            maxLines: 12,
          ),
        ),
      ],
    );
  }
}
