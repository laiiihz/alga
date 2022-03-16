import 'package:flutter/material.dart';

class DateParsedWidget extends StatelessWidget {
  final DateTime date;
  const DateParsedWidget({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Chip coloredChip(String data) => Chip(
          label: Text(data),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
        );
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        coloredChip('${date.year} Year'),
        coloredChip('${date.month}Month'),
        coloredChip('${date.day}Day'),
        coloredChip('${date.hour}Hour'),
        coloredChip('${date.minute}Minute'),
        coloredChip('${date.second}Second'),
        coloredChip('${date.millisecond}Millisecond'),
        coloredChip('Weekday${date.weekday}'),
        if (date.isUtc) coloredChip('UTC'),
        coloredChip(date.timeZoneName),
        coloredChip('${date.timeZoneOffset.inHours}'),
      ],
    );
  }
}
