import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/generators/uuid_generator/uuid_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
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
    bool isDark = FluentTheme.of(context).brightness == Brightness.dark;
    return ToolView.scrollVertical(
      title: Text(S.of(context).generatorUUID),
      children: [
        AppTitle(title: S.of(context).configuration),
        ToolViewConfig(
          leading: const Icon(Icons.horizontal_rule),
          title: const Text('Hypens'),
          trailing: ToggleSwitch(
            checked: _provider.hypens,
            onChanged: (value) {
              _provider.hypens = value;
            },
          ),
        ),
        ToolViewConfig(
          leading: const Icon(Icons.text_fields),
          title: const Text('Upper case'),
          trailing: ToggleSwitch(
            checked: _provider.upperCase,
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
          trailing: Combobox(
            items: UUIDVersion.values.map((e) {
              return ComboboxItem(child: Text(e.value), value: e);
            }).toList(),
            value: _provider.version,
            onChanged: (UUIDVersion? version) {
              _provider.version = version ?? UUIDVersion.v4;
            },
          ),
        ),
        const AppTitle(title: 'generate'),
        Row(
          children: [
            Button(
              child: const Text('Generate UUIDs'),
              onPressed: () {
                _provider.generate();
              },
              style: ButtonStyle(
                backgroundColor: isDark
                    ? ButtonState.all(Colors.blue['darker'])
                    : ButtonState.all(Colors.blue['lightest']),
                foregroundColor: isDark
                    ? ButtonState.all(Colors.white)
                    : ButtonState.all(Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('X'),
            ),
            SizedBox(
              width: 100,
              child: TextBox(
                placeholder: '1',
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
            Button(
              child: const Icon(Icons.copy),
              onPressed: () async {
                await _provider.copy();
              },
            ),
            Button(
              child: const Icon(Icons.clear),
              onPressed: () {},
            ),
          ],
        ),
        TextBox(
          minLines: 10,
          maxLines: 20,
          controller: _provider.resultController,
        ),
      ],
    );
  }
}
