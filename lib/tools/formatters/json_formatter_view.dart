import 'package:fluent_ui/fluent_ui.dart';

class JsonFormatterView extends StatefulWidget {
  const JsonFormatterView({Key? key}) : super(key: key);

  @override
  State<JsonFormatterView> createState() => _JsonFormatterViewState();
}

class _JsonFormatterViewState extends State<JsonFormatterView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('JSON formatter'),
      ),
      content: Row(
        children: [],
      ),
    );
  }
}
