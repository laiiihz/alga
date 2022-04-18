import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/formatters/formatter_abstract.dart';
import 'package:alga/tools/widgets/formatter_view.dart';
import 'package:py_dict_parser/py_dict_parser.dart';

part './py_dict_formatter_provider.dart';

class PyDictFormatterView extends StatefulWidget {
  const PyDictFormatterView({Key? key}) : super(key: key);

  @override
  State<PyDictFormatterView> createState() => _PyDictFormatterViewState();
}

class _PyDictFormatterViewState extends State<PyDictFormatterView> {
  final provider = PyDictProvider();
  @override
  Widget build(BuildContext context) {
    return FormatterView(
      title: const Text('Python Dict Formatter'),
      configs: const [],
      onChanged: provider.onChanged,
      lang: '',
    );
  }
}
