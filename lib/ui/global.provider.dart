import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global.provider.g.dart';

@Riverpod(keepAlive: true)
bool isDesktop(IsDesktopRef ref) {
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

@Riverpod(keepAlive: true)
FutureOr<String> appVersion(AppVersionRef ref) async {
  final info = await PackageInfo.fromPlatform();
  return '${info.version}+${info.buildNumber}';
}
