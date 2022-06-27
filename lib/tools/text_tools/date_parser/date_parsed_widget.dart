import 'package:alga/constants/import_helper.dart';

class DateParsedWidget extends StatelessWidget {
  final DateTime date;
  const DateParsedWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    GestureDetector coloredChip(String data, [String? helpText]) =>
        GestureDetector(
          onTap: () {
            ClipboardUtil.copy(data);
          },
          child: Tooltip(
            message: S.of(context).clickToCopy,
            child: Chip(
              label: Text('$data${helpText == null ? '' : ' ($helpText) '}'),
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        );
    final tzOffset = date.timeZoneOffset.inHours;
    final weekdays = MaterialLocalizations.of(context).narrowWeekdays;
    String weekday = date.weekday == 7 ? weekdays[0] : weekdays[date.weekday];
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        coloredChip('${date.year}'.padLeft(4, '0'), 'Year'),
        coloredChip('${date.month}'.padLeft(2, '0'), 'Month'),
        coloredChip('${date.day}'.padLeft(2, '0'), 'Day'),
        coloredChip('${date.hour}'.padLeft(2, '0'), 'Hour'),
        coloredChip('${date.minute}'.padLeft(2, '0'), 'Minute'),
        coloredChip('${date.second}'.padLeft(2, '0'), 'Second'),
        coloredChip('${date.millisecond}'.padLeft(3, '0'), 'Millisecond'),
        coloredChip(weekday, 'Weekday'),
        if (date.isUtc) coloredChip('UTC'),
        coloredChip(date.timeZoneName),
        coloredChip(tzOffset.isNegative ? '$tzOffset' : '+$tzOffset'),
      ],
    );
  }
}
