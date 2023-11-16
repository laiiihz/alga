import 'package:alga/tools/text_tools/date_parser/date_parser.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';
import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/tools/text_tools/date_parser/date_ext.dart';
import 'package:alga/tools/text_tools/date_parser/date_parsed_widget.dart';

import 'date_parser_view_provider.dart';

part './date_operation_widget.dart';

class DateParserRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DateParserView();
  }
}

class DateParserView extends StatefulWidget {
  const DateParserView({super.key});

  @override
  State<DateParserView> createState() => _DateParserViewState();
}

class _DateParserViewState extends State<DateParserView> {
  @override
  Widget build(BuildContext context) {
    return DateParserPage();
    return ScrollableToolView(
      title: Text(S.of(context).dateParser),
      children: [
        AppTitleWrapper(
          title: S.of(context).dateParserdate,
          actions: [
            HelperIconButton(
              title: Text(context.tr.supportedDateFormat),
              content: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  for (var item in supportDateFormat) Chip(label: Text(item))
                ],
              ),
            ),
            Consumer(builder: (context, ref, _) {
              return TextButton(
                onPressed: () {
                  ref.read(dateControllerProvider).text =
                      DateTime.now().toIso8601String();
                },
                child: Text(context.tr.currentDate),
              );
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              controller: ref.read(dateControllerProvider),
            );
          }),
        ),
        Consumer(builder: (context, ref, _) {
          final date = ref.watch(dateParserProvider);
          if (date == null) return const SizedBox.shrink();
          return Column(
            children: [
              AppTitleWrapper(
                title: S.of(context).parsedDate,
                child: DateParsedWidget(date: date),
              ),
              AppTitleWrapper(
                title: S.of(context).iso8601Date,
                actions: [
                  CopyButtonWidget(text: date.toIso8601String()),
                ],
                child: AppTextField(text: date.toIso8601String()),
              ),
            ],
          );
        }),
        AppTitleWrapper(
          title: context.tr.dateCalculation,
          child: const DateOperationWidget(),
        ),
        Consumer(builder: (context, ref, _) {
          return AppTitleWrapper(
            title: context.tr.dateCustomFormat,
            actions: [
              HelperIconButton(
                title: Text(context.tr.dateFormatHelp),
                content: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    for (var item in dateFormatHelp) Chip(label: Text(item))
                  ],
                ),
              ),
              PasteButtonWidget(formatControllerProvider),
            ],
            child: TextField(
              controller: ref.read(formatControllerProvider),
            ),
          );
        }),
        Consumer(builder: (context, ref, _) {
          return AppTitleWrapper(
            title: S.of(context).formattedDateString,
            actions: [
              CopyButtonWithText.raw(ref.watch(formatResultProvider)),
            ],
            child: AppTextField(text: ref.watch(formatResultProvider) ?? ''),
          );
        }),
      ],
    );
  }
}
