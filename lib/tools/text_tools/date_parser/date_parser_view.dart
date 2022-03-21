import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/text_tools/date_parser/date_parsed_widget.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:alga/widgets/ref_readonly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

part './date_parser_provider.dart';

class DateParserView extends StatefulWidget {
  const DateParserView({Key? key}) : super(key: key);

  @override
  State<DateParserView> createState() => _DateParserViewState();
}

class _DateParserViewState extends State<DateParserView> {
  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: const Text('Date Parser'),
      children: [
        AppTitleWrapper(
          title: 'Date',
          actions: const [],
          child: RefReadonly(builder: (ref) {
            return TextField(
              controller: ref.read(_dateController),
              onChanged: (_) {
                ref.refresh(_date);
              },
            );
          }),
        ),
        Consumer(builder: (context, ref, _) {
          final date = ref.watch(_date);
          if (date == null) return const SizedBox.shrink();
          return Column(
            children: [
              AppTitleWrapper(
                title: 'Parsed Date',
                child: DateParsedWidget(date: date),
              ),
              AppTitleWrapper(
                title: 'Iso8601 Date',
                actions: [
                  IconButton(
                    onPressed: () {
                      ClipboardUtil.copy(date.toIso8601String());
                    },
                    icon: const Icon(Icons.copy),
                  ),
                ],
                child: AppTextBox(data: date.toIso8601String()),
              ),
            ],
          );
        }),
        RefReadonly(builder: (ref) {
          return AppTitleWrapper(
            title: 'Custom Format',
            actions: [
              IconButton(
                onPressed: () async {
                  ref.read(_formatController).text =
                      await ClipboardUtil.paste();
                },
                icon: const Icon(Icons.copy),
              ),
            ],
            child: TextField(
              controller: ref.read(_formatController),
              onChanged: (_) {
                ref.refresh(_formatResult);
              },
            ),
          );
        }),
        Consumer(builder: (context, ref, _) {
          return AppTitleWrapper(
            title: 'Formatted Date String',
            actions: [
              IconButton(
                onPressed: () {
                  ClipboardUtil.copy(ref.watch(_formatResult) ?? '');
                },
                icon: const Icon(Icons.copy),
              ),
            ],
            child: AppTextBox(data: ref.watch(_formatResult) ?? ''),
          );
        }),
      ],
    );
  }
}
