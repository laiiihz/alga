import 'package:devtoys/tools/formatters/json_formatter_base.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'abstract/formatter_base_view.dart';
import 'abstract/formatter_config.dart';

enum JsonIndentType {
  space2,
  space4,
  tab,
  zip,
}

extension _Json on JsonIndentType {
  String get name {
    switch (this) {
      case JsonIndentType.space2:
        return '2';
      case JsonIndentType.space4:
        return '4';
      case JsonIndentType.tab:
        return 'tab';
      case JsonIndentType.zip:
        return 'zip';
    }
  }
}

class FormatterJsonView extends StatefulWidget {
  const FormatterJsonView({Key? key}) : super(key: key);

  @override
  State<FormatterJsonView> createState() => _FormatterJsonViewState();
}

class _FormatterJsonViewState extends State<FormatterJsonView> {
  final base = JsonFormatterBase();
  var _type = JsonIndentType.space2;

  setConfig() {
    base.configs = [JsonFormatterBase.jsonIdent(_type)];
  }

  @override
  Widget build(BuildContext context) {
    return FormatterBaseView(
      base: base,
      configs: [
        FormatterConfig(
          title: 'title',
          trailing: Combobox<JsonIndentType>(
            items: JsonIndentType.values
                .map((JsonIndentType e) => ComboboxItem(
                    child: Text(e.name, softWrap: false), value: e))
                .toList(),
            value: _type,
            onChanged: (type) {
              _type = type ?? JsonIndentType.space2;
              setConfig();
              base.convertIt();
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
