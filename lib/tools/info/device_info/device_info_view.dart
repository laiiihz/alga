import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/info/device_info/device_info_provider.dart';

class DeviceInfoView extends StatefulWidget {
  const DeviceInfoView({Key? key}) : super(key: key);

  @override
  State<DeviceInfoView> createState() => _DeviceInfoViewState();
}

class _DeviceInfoViewState extends State<DeviceInfoView> {
  final _provider = DeviceInfoProvider();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _provider.init(),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return ToolView.scrollVertical(
          title: const Text('Device Info'),
          children: [
            const AppTitle(title: 'Common Info'),
            ..._provider.commonInfomations
                .map((e) => ToolViewConfig(
                      title: Text(e.title(context)),
                      subtitle: Text(e.value),
                    ))
                .toList(),
            const AppTitle(title: 'Platform Info'),
            ..._provider.infomations
                .map((e) => ToolViewConfig(
                      title: Text(e.title(context)),
                      subtitle: Text(e.value),
                    ))
                .toList()
          ],
        );
      },
    );
  }
}
