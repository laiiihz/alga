import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'date_parser.dart';

part 'date_parser.provider.g.dart';

const List<String> supportedDateFormat = [
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

@riverpod
(DateTime?, String?) dateResult(DateResultRef ref) {
  final content = ref.watch(useContent);
  if (content.isEmpty) return (null, null);

  final customFormat = ref.watch(useCustomFormat);

  if (customFormat) {
    final customFormatContent = ref.watch(useCustomFormatContent);
    try {
      return (DateFormat(customFormatContent).parse(content), null);
    } on FormatException catch (e) {
      return (null, e.message);
    } catch (e) {
      return (null, e.toString());
    }
  } else {
    try {
      return (DateTime.parse(content), null);
    } on FormatException catch (e) {
      return (null, e.message);
    } catch (e) {
      return (null, e.toString());
    }
  }
}

@riverpod
String formatDateResult(FormatDateResultRef ref) {
  final format = ref.watch(useFormatContent);
  final date = ref.watch(dateResultProvider);
  if (date.$1 == null) return '';
  if (format.isEmpty) return '';
  return DateFormat(format).format(date.$1!);
}
