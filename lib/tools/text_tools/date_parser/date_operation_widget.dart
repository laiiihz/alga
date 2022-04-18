part of './date_parser_view.dart';

class DateOperationWidget extends ConsumerWidget {
  const DateOperationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(_date);
    if (date == null) return const SizedBox.shrink();
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        _Operation(
          text: 'Next Day',
          onChange: (date) => date.nextDay,
        ),
        _Operation(
          text: 'Previous Day',
          onChange: (date) => date.previousDay,
        ),
        _Operation(
          text: 'Next Month',
          onChange: (date) => date.nextMonth,
        ),
        _Operation(
          text: 'Previous Month',
          onChange: (date) => date.previousMonth,
        ),
        _Operation(
          text: 'Next Year',
          onChange: (date) => date.nextYear,
        ),
        _Operation(
          text: 'Previous Year',
          onChange: (date) => date.previousYear,
        ),
        _Operation(
          text: 'Next Hour',
          onChange: (date) => date.nextHour,
        ),
        _Operation(
          text: 'Previous Hour',
          onChange: (date) => date.previousHour,
        ),
        _Operation(
          text: 'Next Minute',
          onChange: (date) => date.nextMinute,
        ),
        _Operation(
          text: 'Previous Minute',
          onChange: (date) => date.previousMinute,
        ),
        _Operation(
          text: 'Next Second',
          onChange: (date) => date.nextSecond,
        ),
        _Operation(
          text: 'Previous Second',
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
        final date = onChange(ref.watch(_date)!);
        ref.watch(_date.notifier).state = date;
      },
      child: Text(text),
    );
  }
}
