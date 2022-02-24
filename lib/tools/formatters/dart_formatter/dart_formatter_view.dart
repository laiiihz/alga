import 'package:devtoys/tools/formatters/dart_formatter/dart_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../widgets/formatter_view.dart';

class DartFormtterView extends StatefulWidget {
  const DartFormtterView({Key? key}) : super(key: key);

  @override
  State<DartFormtterView> createState() => _DartFormtterViewState();
}

class _DartFormtterViewState extends State<DartFormtterView> {
  final provider = DartProvider();
  @override
  Widget build(BuildContext context) {
    return FormatterView(
      title: const Text('Dart Formatter'),
      configs: const [],
      onChanged: provider.onChanged,
    );
  }
}
