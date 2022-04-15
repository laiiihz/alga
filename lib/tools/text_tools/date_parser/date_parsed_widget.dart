import 'package:alga/constants/import_helper.dart';

class DateParsedWidget extends StatelessWidget {
  final DateTime date;
  const DateParsedWidget({Key? key, required this.date}) : super(key: key);

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
    final weekday =
        MaterialLocalizations.of(context).narrowWeekdays[date.weekday];
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        coloredChip('${date.year}', 'Year'),
        coloredChip('${date.month}', 'Month'),
        coloredChip('${date.day}', 'Day'),
        coloredChip('${date.hour}', 'Hour'),
        coloredChip('${date.minute}', 'Minute'),
        coloredChip('${date.second}', 'Second'),
        coloredChip('${date.millisecond}', 'Millisecond'),
        coloredChip(weekday, 'Weekday'),
        if (date.isUtc) coloredChip('UTC'),
        coloredChip(date.timeZoneName),
        coloredChip(tzOffset.isNegative ? '$tzOffset' : '+$tzOffset'),
      ],
    );
  }
}
