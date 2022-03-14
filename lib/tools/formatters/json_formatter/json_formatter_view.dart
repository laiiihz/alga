import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/formatters/json_formatter/json_enums.dart';
import 'package:alga/tools/formatters/json_formatter/json_provider.dart';

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
      lang: LangHighlightType.json,
      title: Text(S.of(context).formatterJson),
      configs: [
        ToolViewConfig(
          leading: const Icon(Icons.space_bar),
          title: Text(S.of(context).indentation),
          trailing: DropdownButton<JsonIndentType>(
            underline: const SizedBox.shrink(),
            isDense: true,
            items: JsonIndentType.values
                .map((e) => DropdownMenuItem(child: Text(e.name), value: e))
                .toList(),
            onChanged: (iType) {
              provider.type = iType ?? JsonIndentType.space2;
            },
            value: provider.type,
          ),
        ),
      ],
      onChanged: provider.onChanged,
    );
  }
}
