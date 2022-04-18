import 'dart:io';
import 'dart:isolate';

import 'package:alga/constants/import_helper.dart';
import 'package:file_selector/file_selector.dart' as selector;

part './random_file_generator_provider.dart';
part './random_file_util.dart';

class RandomFileGeneratorView extends StatelessWidget {
  const RandomFileGeneratorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
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
                      ref.refresh(_fileSize);
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
                            (e) => PopupMenuItem(child: Text(e.name), value: e))
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
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Success')));
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
