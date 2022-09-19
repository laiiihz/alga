import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/formatters/json_formatter/json_enums.dart';
import 'package:alga/tools/formatters/json_formatter/json_provider.dart';
import '../../widgets/formatter_view.dart';

class JsonFormatterView extends StatefulWidget {
  const JsonFormatterView({super.key});

  @override
  State<JsonFormatterView> createState() => _JsonFormatterViewState();
}

class _JsonFormatterViewState extends State<JsonFormatterView> {
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
          trailing: PopupMenuButton<JsonIndentType>(
              itemBuilder: (context) => JsonIndentType.values
                  .map((e) =>
                      PopupMenuItem(value: e, child: Text(e.name(context))))
                  .toList(),
              onSelected: (iType) {
                provider.type = iType;
              },
              initialValue: provider.type,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(provider.type.name(context)),
              )),
        ),
      ],
      onChanged: provider.onChanged,
    );
  }
}
