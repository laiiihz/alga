import 'package:alga/tools/info/device_info/device_info_provider.dart';
import 'package:alga/utils/constants/import_helper.dart';

class DeviceInfoView extends StatefulWidget {
  const DeviceInfoView({super.key});

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
        return ScrollableToolView(
          title: Text(S.of(context).deviceInfo),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTitle(title: S.of(context).commonInfo),
            ),
            ..._provider.commonInfomations
                .map((e) => DeviceTile(
                      title: e.title(context),
                      value: e.value,
                    ))
                .toList(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTitle(title: S.of(context).platformInfo),
            ),
            ..._provider.infomations
                .map((e) => DeviceTile(
                      title: e.title(context),
                      value: e.value,
                    ))
                .toList()
          ],
        );
      },
    );
  }
}

class DeviceTile extends StatelessWidget {
  const DeviceTile({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 240),
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
