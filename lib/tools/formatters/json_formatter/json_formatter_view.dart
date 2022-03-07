import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/formatters/json_formatter/json_enums.dart';
import 'package:alga/tools/formatters/json_formatter/json_provider.dart';
import 'package:alga/widgets/tool_view_config.dart';
import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

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
    provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormatterView(
      title: Text(S.of(context).formatterJson),
      configs: [
        ToolViewConfig(
          leading: const Icon(FluentIcons.spacebar_24_regular),
          title: const Text('indentation'),
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
