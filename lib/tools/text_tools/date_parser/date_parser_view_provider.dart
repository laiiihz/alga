import 'package:alga/utils/constants/import_helper.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_parser_view_provider.g.dart';

@riverpod
TextEditingController dateController(DateControllerRef ref) {
  final controller = TextEditingController();
  controller.addListener(() => ref.invalidate(dateParserProvider));
  ref.onDispose(controller.dispose);
  return controller;
}

@riverpod
class DateParser extends _$DateParser {
  @override
  DateTime? build() {
    final date = ref.watch(dateControllerProvider).text;
    final parsedDate = DateTime.tryParse(date);
    if (parsedDate != null) {
      return parsedDate;
    }
    int? timestamp = int.tryParse(date);
    if (timestamp != null && timestamp >= 0) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return null;
  }

  update(DateTime date) {
    state = date;
  }
}

@riverpod
TextEditingController formatController(FormatControllerRef ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  controller.addListener(() => ref.invalidate(foramtTextProvider));
  return controller;
}

@riverpod
String foramtText(ForamtTextRef ref) {
  return ref.watch(formatControllerProvider).text;
}

@riverpod
String? formatResult(FormatResultRef ref) {
  final date = ref.watch(dateParserProvider);
  final format = ref.watch(foramtTextProvider);
  if (date == null) return null;
  return DateFormat(format).format(date);
}

const List<String> supportDateFormat = [
  "2012-02-27",
  "2012-02-27 13:27:00",
  "2012-02-27 13:27:00.123456789z",
  "2012-02-27 13:27:00,123456789z",
  "20120227 13:27:00",
  "20120227T132700",
  "20120227",
  "+20120227",
  "2012-02-27T14Z",
  "2012-02-27T14+00:00",
  "-123450101 00:00:00 Z",
  "2002-02-27T14:00:00-0500",
  "2002-02-27T19:00:00Z",
  "timestamp",
];

List<String> dateFormatHelp = [
  'G: era designator',
  'y: year',
  'M: month in year',
  'L: standalone month',
  'd: day in month',
  'c: standalone day',
  'h: hour in am/pm (1~12)',
  'H: hour in day (0~23)',
  'm: minute in hour',
  's: second in minute',
  'S: fractional second',
  'E: day of week',
  'D: day in year',
  'a: am/pm marker',
  'k: hour in day (1~24)',
  'K: hour in am/pm (0~11)',
  'Q: quarter',
  '\': escape for text',
  '\'\': single quote',
];
