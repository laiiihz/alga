import 'dart:io';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/tool_view_config.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

final useListDirectory = booleanConfigProvider(const Key('list-dir'));
final usePort = intConfigProvider(const Key('port'), defaultValue: 8080);
final useAccess =
    booleanConfigProvider(const Key('access'), defaultValue: true);
final useDefaultPath = stringConfigProvider(const Key('default-path'));

class StaticServerRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StaticServerPage();
  }
}

class StaticServerPage extends ConsumerStatefulWidget {
  const StaticServerPage({super.key});

  @override
  ConsumerState<StaticServerPage> createState() => _StaticServerPageState();
}

class _StaticServerPageState extends ConsumerState<StaticServerPage> {
  Directory? dir;
  HttpServer? server;

  @override
  void dispose() {
    server?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(usePort);
    return ScrollableScaffold(
      title: Text(context.tr.staticServerTool),
      configurations: [
        ConfigNumber(
          leading: const Icon(Icons.power_outlined),
          title: const Text('Port'),
          value: usePort,
          max: 65535,
          min: 1,
        ),
        ConfigSwitch(
          leading: const Icon(Icons.list),
          title: const Text('List Directories'),
          value: useListDirectory,
        ),
        ConfigSwitch(
          leading: const Icon(Icons.network_check),
          title: const Text('Accessible on Internet'),
          value: useAccess,
        ),
        ConfigTextField(
          title: const Text('Default Path'),
          provider: useDefaultPath,
          hint: 'index.html',
          expanded: true,
        ),
        ToolViewConfig(
          title: const Text('Select Directory'),
          subtitle: dir == null ? null : Text(dir!.absolute.path),
          onPressed: () async {
            final path = await getDirectoryPath();
            if (path == null) return;
            if (!mounted) return;
            setState(() {
              dir = Directory(path);
            });
          },
        ),
      ],
      children: [
        ElevatedButton(
          onPressed: server == null ? startServer : stopServer,
          child: server == null
              ? const Text('START Server')
              : const Text('STOP Server'),
        ),
      ],
    );
  }

  Future startServer() async {
    if (dir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Select Directory')));
      return;
    }
    final defaultDocument = ref.read(useDefaultPath);
    final handler = createStaticHandler(
      dir!.path,
      defaultDocument: defaultDocument.isEmpty ? null : defaultDocument,
      listDirectories: ref.read(useListDirectory),
    );

    try {
      server = await io.serve(
        handler,
        ref.read(useAccess) ? '0.0.0.0' : 'localhost',
        ref.read(usePort),
        poweredByHeader: 'Dart with Shelf on Alga',
      );
    } catch (e) {
      server?.close();
      server = null;
    }

    if (mounted) setState(() {});
  }

  Future stopServer() async {
    server?.close();
    server = null;
    setState(() {});
  }
}
