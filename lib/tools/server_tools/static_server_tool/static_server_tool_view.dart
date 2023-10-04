import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/tools/server_tools/static_server_tool/static_server_tool_provider.dart';

class StaticServerToolRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StaticServerToolView();
  }
}

class StaticServerToolView extends StatefulWidget {
  const StaticServerToolView({super.key});

  @override
  State<StaticServerToolView> createState() => _StaticServerToolViewState();
}

class _StaticServerToolViewState extends State<StaticServerToolView> {
  final _provider = StaticServerToolProvider();
  update() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _provider.addListener(update);
  }

  @override
  void dispose() {
    _provider.removeListener(update);
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).staticServerTool),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewConfig(
              leading: const Icon(Icons.power_outlined),
              title: const Text('Port'),
              trailing: SizedBox(
                width: 120,
                child: TextField(
                  controller: _provider.portController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    hintText: '8080',
                  ),
                ),
              ),
            ),
            ToolViewSwitchConfig(
              leading: const Icon(Icons.list),
              title: const Text('List Directories'),
              value: (ref) => _provider.listDirectories,
              onChanged: (value, ref) => _provider.listDirectories = value,
            ),
            ToolViewSwitchConfig(
              leading: const Icon(Icons.network_check),
              title: const Text('Accessible on Internet'),
              value: (ref) => _provider.accessOnNet,
              onChanged: (state, ref) {
                _provider.accessOnNet = state;
              },
            ),
            ToolViewConfig(
              title: const Text('Open file'),
              leading: const Icon(Icons.file_open),
              trailing: const Icon(Icons.file_open),
              onPressed: () async {
                bool result = await _provider.openFile();
                if (!result && mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('canceled')));
                }
              },
            ),
            ToolViewConfig(
              leading: const Icon(Icons.podcasts_sharp),
              title: Text(_provider.filePath ?? 'select file'),
              trailing: _provider.isStarted
                  ? TextButton(
                      onPressed: () {
                        _provider.stop();
                      },
                      child: const Text('stop'),
                    )
                  : TextButton(
                      onPressed: () {
                        _provider.startServe();
                      },
                      child: const Text('start'),
                    ),
            ),
            const ToolViewConfig(
              leading: Icon(Icons.u_turn_left),
              title: Text('Default path'),
              trailing: SizedBox.shrink(),
            ),
            TextField(controller: _provider.pathController),
          ],
        ),
        AppTitle(
          title: 'Server Status',
          actions: [
            Chip(
              label: _provider.isStarted
                  ? const Text('Started')
                  : const Text('Stoped'),
            ),
          ],
        ),
      ],
    );
  }
}
