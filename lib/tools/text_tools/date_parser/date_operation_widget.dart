part of './date_parser_view.dart';

class DateOperationWidget extends ConsumerWidget {
  const DateOperationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateParserProvider);
    if (date == null) return const SizedBox.shrink();
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        _Operation(
          text: context.tr.nextDay,
          onChange: (date) => date.nextDay,
        ),
        _Operation(
          text: context.tr.previousDay,
          onChange: (date) => date.previousDay,
        ),
        _Operation(
          text: context.tr.nextMonth,
          onChange: (date) => date.nextMonth,
        ),
        _Operation(
          text: context.tr.previousMonth,
          onChange: (date) => date.previousMonth,
        ),
        _Operation(
          text: context.tr.nextYear,
          onChange: (date) => date.nextYear,
        ),
        _Operation(
          text: context.tr.previousYear,
          onChange: (date) => date.previousYear,
        ),
        _Operation(
          text: context.tr.nextHour,
          onChange: (date) => date.nextHour,
        ),
        _Operation(
          text: context.tr.previousHour,
          onChange: (date) => date.previousHour,
        ),
        _Operation(
          text: context.tr.nextMinute,
          onChange: (date) => date.nextMinute,
        ),
        _Operation(
          text: context.tr.previousMinute,
          onChange: (date) => date.previousMinute,
        ),
        _Operation(
          text: context.tr.nextSecond,
          onChange: (date) => date.nextSecond,
        ),
        _Operation(
          text: context.tr.previousSecond,
          onChange: (date) => date.previousSecond,
        ),
      ],
    );
  }
}

class _Operation extends ConsumerWidget {
  final String text;
  final DateTime Function(DateTime current) onChange;
  const _Operation({Key? key, required this.text, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: () {
        final date = onChange(ref.read(dateParserProvider)!);
        ref.read(dateParserProvider.notifier).update(date);
      },
      child: Text(text),
    );
  }
}
