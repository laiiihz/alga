import 'dart:async';
import 'dart:io';

import 'package:alga/utils/hive_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

abstract class ServiceBase {
  FutureOr run();
  static final values = <ServiceBase>[
    FlutterBindingService(),
    StorageService(),
    WindowService(),
  ];
}

class AppService implements ServiceBase {
  static AppService? _instance;
  AppService._();
  factory AppService() => _instance ??= AppService._();
  @override
  FutureOr run() async {
    for (var service in ServiceBase.values) {
      await service.run();
    }
  }
}

class FlutterBindingService implements ServiceBase {
  static FlutterBindingService? _instance;
  FlutterBindingService._();
  factory FlutterBindingService() => _instance ??= FlutterBindingService._();
  @override
  FutureOr run() {
    WidgetsFlutterBinding.ensureInitialized();
  }
}

class StorageService implements ServiceBase {
  static StorageService? _instance;
  StorageService._();
  factory StorageService() => _instance ??= StorageService._();
  @override
  FutureOr run() async {
    // await Hive.initFlutter();
    await HiveUtil.init();
  }
}

class WindowService implements ServiceBase {
  static WindowService? _instance;
  WindowService._();
  factory WindowService() => _instance ??= WindowService._();

  @override
  FutureOr run() async {
    if (kIsWeb) {
      return;
    } else if (Platform.isAndroid || Platform.isIOS) {
      return;
    } else {
      await windowManager.ensureInitialized();
      windowManager.waitUntilReadyToShow().then((value) async {
        TitleBarStyle style = TitleBarStyle.hidden;
        if (Platform.isWindows) {
          style = TitleBarStyle.normal;
        }
        await windowManager.setTitleBarStyle(
          style,
          windowButtonVisibility: true,
        );

        await windowManager.setTitle('Alga');
        await windowManager.setSkipTaskbar(false);
        await windowManager.setMinimumSize(const Size(800, 600));
      });
    }
  }

  static setTitle(String title) async {
    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isIOS) return;
    await windowManager.setTitle(title);
  }

  static bool get isMobileDevice {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }
}

// class QuickActionService implements ServiceBase {
//   static QuickActionService? _instance;
//   QuickActionService._();
//   factory QuickActionService() => _instance ??= QuickActionService._();

//   final QuickActions quickActions = const QuickActions();
//   @override
//   FutureOr run() async {
//     quickActions.setShortcutItems([]);
//   }
// }
