import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/lorem_ipsum_generator/lorem_ipsum_provider.dart';
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
          leading: const Icon(Icons.text_snippet),
          title: const Text('Type'),
          subtitle: const Text(
              'Generate words,sentences or paragraphs of Lorem ipsum'),
          trailing: PopupMenuButton(
            itemBuilder: (context) {
              return LoremIpsumType.values
                  .map((e) => PopupMenuItem(child: Text(e.value), value: e))
                  .toList();
            },
            initialValue: _provider.type,
            onSelected: (LoremIpsumType type) {
              _provider.type = type;
              _provider.generate();
            },
          ),
        ),
        ToolViewConfig(
          leading: const Icon(Icons.numbers),
          title: const Text('Length'),
          subtitle:
              const Text('Number of words,sentences or paragraphs to generate'),
          trailing: SizedBox(
            width: 60,
            child: TextField(
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
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () => _provider.copy(),
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => _provider.clear(),
            ),
          ],
          child: TextField(
            controller: _provider.outputController,
            minLines: 12,
            maxLines: 12,
          ),
        ),
      ],
    );
  }
}
