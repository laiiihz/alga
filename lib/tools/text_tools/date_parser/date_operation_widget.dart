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
        DateOprt(
          text: context.tr.nextDay,
          onChange: (date) => date.nextDay,
        ),
        DateOprt(
          text: context.tr.previousDay,
          onChange: (date) => date.previousDay,
        ),
        DateOprt(
          text: context.tr.nextMonth,
          onChange: (date) => date.nextMonth,
        ),
        DateOprt(
          text: context.tr.previousMonth,
          onChange: (date) => date.previousMonth,
        ),
        DateOprt(
          text: context.tr.nextYear,
          onChange: (date) => date.nextYear,
        ),
        DateOprt(
          text: context.tr.previousYear,
          onChange: (date) => date.previousYear,
        ),
        DateOprt(
          text: context.tr.nextHour,
          onChange: (date) => date.nextHour,
        ),
        DateOprt(
          text: context.tr.previousHour,
          onChange: (date) => date.previousHour,
        ),
        DateOprt(
          text: context.tr.nextMinute,
          onChange: (date) => date.nextMinute,
        ),
        DateOprt(
          text: context.tr.previousMinute,
          onChange: (date) => date.previousMinute,
        ),
        DateOprt(
          text: context.tr.nextSecond,
          onChange: (date) => date.nextSecond,
        ),
        DateOprt(
          text: context.tr.previousSecond,
          onChange: (date) => date.previousSecond,
        ),
      ],
    );
  }
}

class DateOprt extends ConsumerWidget {
  final String text;
  final DateTime Function(DateTime current) onChange;
  const DateOprt({super.key, required this.text, required this.onChange});

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
