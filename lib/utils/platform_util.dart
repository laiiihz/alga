import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformUtil {
  static bool get isWeb => kIsWeb;
  static bool get isDesktop =>
      kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isFuchsia;
  static bool get isMobile => Platform.isAndroid || Platform.isIOS;
}
