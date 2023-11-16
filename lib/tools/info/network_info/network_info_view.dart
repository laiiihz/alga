import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/info/network_info/network_info.provider.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/device_tile.dart';

class NetworkInfoRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NetworkInfoView();
  }
}

class NetworkInfoView extends ConsumerWidget {
  const NetworkInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScrollableScaffold(
      title: Text(context.tr.networkInfo),
      children: [
        ...ref.watch(networkInfoWrapperProvider).when(
              data: (data) {
                return data
                    .content(context)
                    .map<Widget>((e) => DeviceTile(title: e.$2, value: e.$1));
              },
              error: (e, s) => [Text(e.toString())],
              loading: () =>
                  const [Center(child: CircularProgressIndicator.adaptive())],
            ),
        ref.watch(connectivityProvider).whenOrNull(
              data: (data) {
                return DeviceTile(title: 'mode', value: data.name);
              },
            ) ??
            const SizedBox.shrink(),
      ],
    );
  }
}
