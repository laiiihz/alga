import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/text_tools/date_parser/date_ext.dart';
import 'package:alga/tools/text_tools/date_parser/date_format_helper.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/buttons/help_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:alga/utils/extension/list_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'date_parser.provider.dart';

final useCustomFormat = booleanConfigProvider(const Key('use_custom_format'));
final useCustomFormatContent = stringConfigProvider(const Key('custom_format'));

final useContent = stringConfigProvider(const Key('use_content'));
final useFormatContent = stringConfigProvider(const Key('format_content'));

class DateParserRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DateParserPage();
  }
}

class DateParserPage extends ConsumerStatefulWidget {
  const DateParserPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DateParserPageState();
}

class _DateParserPageState extends ConsumerState<DateParserPage> {
  final _input = TextEditingController();
  final _formatInput = TextEditingController();
  @override
  void initState() {
    super.initState();
    _input.addListener(() {
      ref.read(useContent.notifier).change(_input.text);
    });
    _formatInput.addListener(() {
      ref.read(useFormatContent.notifier).change(_formatInput.text);
    });
  }

  @override
  void dispose() {
    _input.dispose();
    _formatInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateResult = ref.watch(dateResultProvider);
    final parsedDate = dateResult.$1 ?? DateTime.now();
    return ScrollableScaffold(
      title: Text(context.tr.dateParser),
      configurations: [
        ConfigSwitch(
          title: const Text('Use Custom Format'),
          value: useCustomFormat,
        ),
        CrossFade(
          state: ref.watch(useCustomFormat),
          first: ConfigTextField(
            title: const Text('Custom Format'),
            provider: useCustomFormatContent,
            expanded: true,
          ),
        ),
      ],
      children: [
        AlgaToolbar(
          title: Text(context.tr.dateParserdate),
          actions: [
            TextButton.icon(
              onPressed: () {
                DateFormatHelper.show(context);
              },
              icon: const Icon(Icons.help),
              label: const Text('FORMAT'),
            ),
            CustomIconButton(
              tooltip: context.tr.currentDate,
              onPressed: () {
                _input.text = DateTime.now().toIso8601String();
              },
              icon: const Icon(Icons.access_time_rounded),
            ),
            HelpButton(
              onPressed: showSupportedDateFormatDialog,
              tooltip: context.tr.dateFormatHelp,
            ),
          ],
        ),
        AppInput(
          controller: _input,
          decoration: InputDecoration(errorText: dateResult.$2),
        ),
        const AlgaToolbar(),
        AppTextField(text: dateResult.$1?.toIso8601String()),
        CrossFade(
          state: dateResult.$1 != null,
          first: Column(
            children: [
              CanCopyDate(dateResult.$1 ?? DateTime.now()),
              const AlgaToolbar(title: Text('Date Operations')),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <String, DateTime Function()>{
                  context.tr.previousYear: () => parsedDate.previousYear,
                  context.tr.nextYear: () => parsedDate.nextYear,
                  context.tr.previousMonth: () => parsedDate.previousMonth,
                  context.tr.nextMonth: () => parsedDate.nextMonth,
                  context.tr.previousDay: () => parsedDate.previousDay,
                  context.tr.nextDay: () => parsedDate.nextDay,
                  context.tr.previousHour: () => parsedDate.previousHour,
                  context.tr.nextHour: () => parsedDate.nextHour,
                  context.tr.previousMinute: () => parsedDate.previousMinute,
                  context.tr.nextMinute: () => parsedDate.nextMinute,
                  context.tr.previousSecond: () => parsedDate.previousSecond,
                  context.tr.nextSecond: () => parsedDate.nextSecond,
                }
                    .entries
                    .map((e) => OperationChip(
                          name: e.key,
                          onTap: () {
                            _input.text = e.value().toIso8601String();
                          },
                        ))
                    .toList(),
              ),
              AlgaToolbar(
                title: Text(context.tr.format),
                actions: [
                  HelpButton(onPressed: () => DateFormatHelper.show(context)),
                ],
              ),
              AppInput(controller: _formatInput),
              AlgaToolbar(
                actions: [
                  CopyButton(() => ref.read(formatDateResultProvider)),
                ],
              ),
              AppTextField(text: ref.watch(formatDateResultProvider)),
            ].sep(const SizedBox(height: 4)),
          ),
        ),
      ],
    );
  }

  Future<void> showSupportedDateFormatDialog() async {
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return AlertDialog(
          title: Text(context.tr.supportedDateFormat),
          content: Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                supportedDateFormat.map((e) => Chip(label: Text(e))).toList(),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(context.mtr.okButtonLabel),
            ),
          ],
        );
      },
    );
  }
}

class CanCopyDate extends StatelessWidget {
  const CanCopyDate(this.date, {super.key});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: {
            'timestamp': date.millisecondsSinceEpoch,
            'Year': date.year,
            'Month': date.month,
            'Day': date.day,
            'Hour': date.hour,
            'Minute': date.minute,
            'Second': date.second,
            'Millisecond': date.millisecond,
            'Microsecond': date.microsecond,
            'Timezone': date.timeZoneName,
            'Timezone offset':
                (date.timeZoneOffset.inMinutes / 60).toStringAsFixed(1),
            'isUTC': date.isUtc,
            'weekday': context
                .mtr.narrowWeekdays[date.weekday == 7 ? 0 : date.weekday],
          }.entries.map((e) => CopyChip(e.key, e.value)).toList(),
        ),
      ),
    );
  }
}

class CopyChip extends StatelessWidget {
  const CopyChip(this.name, this.label, {super.key});
  final String name;
  final Object label;
  @override
  Widget build(BuildContext context) {
    return ActionChip.elevated(
      label: Text.rich(TextSpan(
        children: [
          TextSpan(
            text: name,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          const TextSpan(text: '  '),
          TextSpan(text: label.toString()),
        ],
      )),
      onPressed: () {
        ClipboardUtil.copy(label.toString());
      },
    );
  }
}

class OperationChip extends StatelessWidget {
  const OperationChip({super.key, required this.name, required this.onTap});
  final String name;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ActionChip.elevated(label: Text(name), onPressed: onTap);
  }
}
