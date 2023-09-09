import 'package:alga/tools/info/device_info/device_info_view.dart';
import 'package:alga/tools/info/network_info/network_info.provider.dart';
import 'package:alga/ui/widgets/scaffold/tool_scaffold.dart';
import 'package:alga/utils/constants/import_helper.dart';

class NetworkInfoView extends ConsumerWidget {
  const NetworkInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToolScaffold.scroll(
      title: Text(S.of(context).networkInfo),
      body: Column(
        children: [
          ref.watch(networkInfoWrapperProvider).when(
                data: (data) {
                  return Column(
                    children: data
                        .content(context)
                        .map<Widget>(
                            (e) => DeviceTile(title: e.$2, value: e.$1 ?? ''))
                        .toList(),
                  );
                },
                error: (e, s) => Text(e.toString()),
                loading: () =>
                    const Center(child: CircularProgressIndicator.adaptive()),
              ),
          ref.watch(connectivityProvider).whenOrNull(
                data: (data) {
                  return DeviceTile(title: 'mode', value: data.name);
                },
              ) ??
              const SizedBox.shrink(),
        ],
      ),
    );
  }
}
