import 'dart:io';

import 'package:alga/utils/constants/import_helper.dart';

final isDesktop = StateProvider(
  (ref) => Platform.isWindows || Platform.isLinux || Platform.isMacOS,
);
