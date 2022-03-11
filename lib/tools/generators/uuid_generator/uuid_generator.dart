import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/uuid_generator/uuid_provider.dart';
import 'package:flutter/services.dart';

class UUIDGeneratorView extends StatefulWidget {
  const UUIDGeneratorView({Key? key}) : super(key: key);

  @override
  State<UUIDGeneratorView> createState() => _UUIDGeneratorViewState();
}

class _UUIDGeneratorViewState extends State<UUIDGeneratorView> {
  final _provider = UUIDProvider();
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
      title: Text(S.of(context).generatorUUID),
      children: [
        AppTitle(title: S.of(context).configuration),
        ToolViewConfig(
          leading: const Icon(Icons.horizontal_rule),
          title: const Text('Hypens'),
          trailing: Switch(
            value: _provider.hypens,
            onChanged: (value) {
              _provider.hypens = value;
            },
          ),
        ),
        ToolViewConfig(
          leading: const Icon(Icons.text_fields),
          title: const Text('Upper case'),
          trailing: Switch(
            value: _provider.upperCase,
            onChanged: (value) {
              _provider.upperCase = value;
            },
          ),
        ),
        ToolViewConfig(
          leading: const Icon(Icons.info_outline),
          title: const Text('UUID Version'),
          subtitle:
              const Text('Choose the version of UUID version to generate'),
          trailing: PopupMenuButton(
            itemBuilder: (context) {
              return UUIDVersion.values.map((e) {
                return PopupMenuItem(child: Text(e.value), value: e);
              }).toList();
            },
            initialValue: _provider.version,
            onSelected: (UUIDVersion version) {
              _provider.version = version;
            },
          ),
        ),
        const AppTitle(title: 'generate'),
        Row(
          children: [
            ElevatedButton(
              child: const Text('Generate UUIDs'),
              onPressed: () {
                _provider.generate();
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('X'),
            ),
            SizedBox(
              width: 100,
              child: TextField(
                controller: _provider.numberController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  final _value = int.tryParse(value);
                  _provider.count = _value ?? 1;
                },
              ),
            )
          ],
        ),
        AppTitle(
          title: 'UUIDs',
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () async {
                await _provider.copy();
              },
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {},
            ),
          ],
        ),
        TextField(
          minLines: 2,
          maxLines: 20,
          controller: _provider.resultController,
        ),
      ],
    );
  }
}
