import 'package:alga/tools/converters/number_base_converter/number_base_converter_provider.dart';
import 'package:alga/constants/import_helper.dart';

class NumberBaseConverterView extends StatefulWidget {
  const NumberBaseConverterView({Key? key}) : super(key: key);

  @override
  State<NumberBaseConverterView> createState() =>
      _NumberBaseConverterViewState();
}

class _NumberBaseConverterViewState extends State<NumberBaseConverterView> {
  late NumberBaseConverterProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = NumberBaseConverterProvider(context);
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).numberBaseConverter),
      children: _provider.controllers.map((e) {
        return AppTitleWrapper(
          title: e.title,
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () => e.copy(),
            ),
          ],
          child: TextField(
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
