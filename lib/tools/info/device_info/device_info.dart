import 'dart:io';

import 'package:alga/tools/info/device_info/android_logo.dart';
import 'package:alga/tools/info/device_info/device_info.provider.dart';
import 'package:alga/tools/info/widgets/device_tile.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/scaffold/tool_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/utils/constants/import_helper.dart';

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

  Widget build2(BuildContext context, WidgetRef ref) {
    return ToolScaffold.scroll(
      title: Text(context.tr.deviceInfo),
      actions: [
        if (Platform.isAndroid) const AndroidLogo(),
      ],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTitle(title: S.of(context).commonInfo),
          ),
          ...Part.fromCommon().map((p) {
            return DeviceTile(title: p.title(context), value: p.value);
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTitle(title: S.of(context).platformInfo),
          ),
          ...ref.watch(deviceInfoPartsProvider).whenOrNull(
                  data: (data) => data.map((e) {
                        return DeviceTile(
                            title: e.title(context), value: e.value);
                      })) ??
              [],
        ],
      ),
    );
  }
}
