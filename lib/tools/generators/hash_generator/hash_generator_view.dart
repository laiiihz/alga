import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/hash_generator/hash_provider.dart';

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
            Expanded(child: TextField(controller: e.controller)),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.copy),
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
      title: Text(S.of(context).generatorHash),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewConfig(
              leading: const Icon(Icons.text_fields),
              title: const Text('UpperCase'),
              trailing: Switch.adaptive(
                value: _provider.upperCase,
                onChanged: (value) {
                  _provider.upperCase = value;
                },
              ),
            ),
            ToolViewConfig(
              title: const Text('HMAC'),
              subtitle: const Text('Keyed-hash message authentication code'),
              trailing: Switch.adaptive(
                value: _provider.showHmac,
                onChanged: (value) {
                  _provider.showHmac = value;
                  _provider.generate();
                },
              ),
            ),
          ],
        ),
        AppTitle(
          title: S.of(context).input,
          actions: [
            IconButton(
              icon: const Icon(Icons.paste),
              onPressed: () {
                _provider.setInputFormClipboard();
              },
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _provider.inputController.clear();
              },
            ),
          ],
        ),
        TextField(
          minLines: 2,
          maxLines: 12,
          controller: _provider.inputController,
          onChanged: (text) {
            _provider.generate();
          },
        ),
        if (_provider.showHmac)
          TextField(
            minLines: 1,
            maxLines: 12,
            controller: _provider.optionalController,
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
