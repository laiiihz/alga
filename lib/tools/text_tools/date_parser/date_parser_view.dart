import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/text_tools/date_parser/date_parsed_widget.dart';
import 'package:alga/tools/text_tools/date_parser/date_parser_provider.dart';

class DateParserView extends StatefulWidget {
  const DateParserView({Key? key}) : super(key: key);

  @override
  State<DateParserView> createState() => _DateParserViewState();
}

class _DateParserViewState extends State<DateParserView> {
  final _provider = DateParserProvider();
  update() => setState(() {});
  @override
  void initState() {
    super.initState();
    _provider.addListener(update);
  }

  @override
  void dispose() {
    _provider.removeListener(update);
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: const Text('Date Parser'),
      children: [
        AppTitleWrapper(
          title: 'Date',
          actions: const [],
          child: TextField(
            controller: _provider.inputController,
            onChanged: (_) {
              _provider.update();
            },
          ),
        ),
        if (_provider.date != null)
          AppTitleWrapper(
            title: 'Parsed Date',
            actions: const [],
            child: DateParsedWidget(date: _provider.date!),
          ),
        if (_provider.date != null)
          AppTitleWrapper(
            title: 'Iso8601 Date',
            actions: const [],
            child: AppTextBox(data: _provider.date!.toIso8601String()),
          ),
        if (_provider.date != null)
          AppTitleWrapper(
            title: 'Custom Format',
            actions: const [],
            child: TextField(
              controller: _provider.formatController,
              onChanged: (_) {
                _provider.format();
              },
            ),
          ),
        if (_provider.date != null)
          AppTitleWrapper(
            title: 'Formatted Date String',
            actions: const [],
            child: AppTextBox(data: _provider.formatText),
          ),
      ],
    );
  }
}
