import 'dart:io';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/info/device_info/android_logo.dart';
import 'package:alga/tools/info/device_info/device_info.provider.dart';
import 'package:alga/tools/info/widgets/device_tile.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeviceInfoRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DeviceInfoView();
  }
}

class DeviceInfoView extends ConsumerWidget {
  const DeviceInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScrollableScaffold(
      title: Text(context.tr.deviceInfo),
      actions: [
        if (Platform.isAndroid) const AndroidLogo(),
      ],
      children: [
        AlgaToolbar(title: Text(context.tr.commonInfo)),
        ...Part.fromCommon().map((p) {
          return DeviceTile(title: p.title(context), value: p.value);
        }),
        AlgaToolbar(title: Text(context.tr.platformInfo)),
        ...ref.watch(deviceInfoPartsProvider).whenOrNull(
                data: (data) => data.map((e) {
                      return DeviceTile(
                          title: e.title(context), value: e.value);
                    })) ??
            [],
      ],
    );
  }
}
