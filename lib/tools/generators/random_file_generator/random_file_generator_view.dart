import 'dart:io';
import 'dart:isolate';

import 'package:alga/ui/widgets/tool_view.dart';
import 'package:alga/ui/widgets/tool_view_config.dart';
import 'package:file_selector/file_selector.dart' as selector;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part './random_file_generator_provider.dart';
part './random_file_util.dart';

class RandomFileGeneratorRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RandomFileGeneratorView();
  }
}

class RandomFileGeneratorView extends StatelessWidget {
  const RandomFileGeneratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: const Text('Random File Generator'),
      children: [
        ToolViewConfig(
          title: const Text('File Size'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 60,
                child: Consumer(builder: (context, ref, _) {
                  return TextField(
                    controller: ref.watch(_sizeValue),
                    onChanged: (_) {
                      return ref.refresh(_fileSize);
                    },
                  );
                }),
              ),
              const SizedBox(width: 4),
              Consumer(builder: (context, ref, _) {
                return PopupMenuButton<FileType>(
                  itemBuilder: (context) {
                    return FileType.values
                        .map(
                            (e) => PopupMenuItem(value: e, child: Text(e.name)))
                        .toList();
                  },
                  initialValue: ref.watch(_sizeType),
                  child: Text(ref.watch(_sizeType).name),
                  onSelected: (state) {
                    ref.watch(_sizeType.notifier).state = state;
                  },
                );
              })
            ],
          ),
        ),
        Consumer(builder: (context, ref, _) {
          return ElevatedButton.icon(
            onPressed: () async {
              final path = await _pickSaveDir();
              if (path == null) {
                return;
              } else {
                _genFile(ref, path);
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Success')));
                }
              }
            },
            icon: const Icon(Icons.file_copy),
            label: const Text('Generate'),
          );
        }),
      ],
    );
  }
}
