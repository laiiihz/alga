import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'uri_parser.dart';

part 'urI_parser.provider.g.dart';

@riverpod
(Uri?, String?) uri(UriRef ref) {
  final content = ref.watch(useContent);
  if (content.isEmpty) return (null, null);
  try {
    return (Uri.parse(content), null);
  } on FormatException catch (e) {
    return (null, e.message);
  }
}
