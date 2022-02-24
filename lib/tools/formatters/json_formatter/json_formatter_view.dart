import 'package:devtoys/tools/formatters/abstract/formatter_config.dart';
import 'package:devtoys/tools/formatters/json_formatter/json_enums.dart';
import 'package:devtoys/tools/formatters/json_formatter/json_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../widgets/formatter_view.dart';

class JsonFormtterView extends StatefulWidget {
  const JsonFormtterView({Key? key}) : super(key: key);

  @override
  State<JsonFormtterView> createState() => _JsonFormtterViewState();
}

class _JsonFormtterViewState extends State<JsonFormtterView> {
  final provider = JsonProvider();
  update() => setState(() {});

  @override
  void initState() {
    super.initState();
    provider.addListener(update);
  }

  @override
  void dispose() {
    provider.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormatterView(
      title: const Text('Json Formatter'),
      configs: [
        FormatterConfig(
          title: 'title',
          trailing: Combobox<JsonIndentType>(
            items: JsonIndentType.values
                .map((e) => ComboboxItem(child: Text(e.name), value: e))
                .toList(),
            value: provider.type,
            onChanged: (iType) =>
                provider.type = iType ?? JsonIndentType.space2,
          ),
        ),
      ],
      onChanged: provider.onChanged,
    );
  }
}
