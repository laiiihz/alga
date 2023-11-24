import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global.provider.g.dart';

@Riverpod(keepAlive: true)
bool isDesktop(IsDesktopRef ref) {
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}
