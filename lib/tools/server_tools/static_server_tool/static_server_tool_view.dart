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
      title: const Text('Static Server Tool'),
      children: [
        AppTitle(
          title: 'Open file',
          actions: [
            IconButton(
              onPressed: () async {
                bool result = await _provider.openFile();
                if (!result) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('canceled')));
                }
              },
              icon: const Icon(Icons.file_open),
            ),
          ],
        ),
        AppTitle(
          title: _provider.filePath ?? 'select file',
          actions: [
            if (!_provider.isStarted)
              TextButton(
                onPressed: () {
                  _provider.startServe();
                },
                child: const Text('start'),
              ),
            if (_provider.isStarted)
              TextButton(
                onPressed: () {
                  _provider.stop();
                },
                child: const Text('stop'),
              ),
          ],
        ),
      ],
    );
  }
}
