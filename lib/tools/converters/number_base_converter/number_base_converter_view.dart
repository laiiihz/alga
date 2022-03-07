import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/converters/number_base_converter/number_base_converter_provider.dart';

class NumberBaseConverterView extends StatefulWidget {
  const NumberBaseConverterView({Key? key}) : super(key: key);

  @override
  State<NumberBaseConverterView> createState() =>
      _NumberBaseConverterViewState();
}

class _NumberBaseConverterViewState extends State<NumberBaseConverterView> {
  final _provider = NumberBaseConverterProvider();
  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).numberBaseConverter),
      children: _provider.controllers.map((e) {
        return AppTitleWrapper(
          title: e.title,
          actions: [
            Button(
              child: const Icon(FluentIcons.copy),
              onPressed: () => e.copy(),
            ),
          ],
          child: TextBox(
            controller: e.controller,
            inputFormatters: e.formatter,
            onChanged: (_) {
              _provider.onUpdate(e);
            },
          ),
        );
      }).toList(),
    );
  }
}
