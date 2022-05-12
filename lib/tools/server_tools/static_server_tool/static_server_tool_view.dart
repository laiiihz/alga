import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/server_tools/static_server_tool/static_server_tool_provider.dart';

class StaticServerToolView extends StatefulWidget {
  const StaticServerToolView({Key? key}) : super(key: key);

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
    return ToolView.scrollVertical(
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
            ToolViewConfig(
              leading: const Icon(Icons.list),
              title: const Text('List Directories'),
              trailing: Switch(
                value: _provider.listDirectories,
                onChanged: (state) {
                  _provider.listDirectories = state;
                },
              ),
            ),
            ToolViewConfig(
              leading: const Icon(Icons.network_check),
              title: const Text('Accessible on Internet'),
              trailing: Switch(
                value: _provider.accessOnNet,
                onChanged: (state) {
                  _provider.accessOnNet = state;
                },
              ),
            ),
            ToolViewConfig(
              title: const Text('Open file'),
              leading: const Icon(Icons.file_open),
              trailing: IconButton(
                onPressed: () async {
                  bool result = await _provider.openFile();
                  if (!result && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('canceled')));
                  }
                },
                icon: const Icon(Icons.file_open),
              ),
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
