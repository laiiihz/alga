extension DateExt on DateTime {
  copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
    int? nanosecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  DateTime get nextDay => copyWith(day: day + 1);
  DateTime get previousDay => copyWith(day: day - 1);
  DateTime get nextMonth => copyWith(month: month + 1);
  DateTime get previousMonth => copyWith(month: month - 1);
  DateTime get nextYear => copyWith(year: year + 1);
  DateTime get previousYear => copyWith(year: year - 1);

  DateTime get nextHour => copyWith(hour: hour + 1);
  DateTime get previousHour => copyWith(hour: hour - 1);
  DateTime get nextMinute => copyWith(minute: minute + 1);
  DateTime get previousMinute => copyWith(minute: minute - 1);
  DateTime get nextSecond => copyWith(second: second + 1);
  DateTime get previousSecond => copyWith(second: second - 1);
}
