import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/image_util.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:path/path.dart' as path;

part './blur_hash_provider.dart';

class BlurHashView extends StatefulWidget {
  const BlurHashView({Key? key}) : super(key: key);

  @override
  State<BlurHashView> createState() => _BlurHashViewState();
}

class _BlurHashViewState extends State<BlurHashView> {
  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).blurHashTool),
      children: [
        ToolViewWrapper(children: [
          ToolViewConfig(
            leading: const Icon(Icons.image),
            title: Text(S.of(context).pickImage),
            trailing: Consumer(builder: (context, ref, _) {
              return TextButton(
                onPressed: () async {
                  await ref.read(_currentFile.notifier).pick();
                },
                child: Text(S.of(context).pickImagePick),
              );
            }),
          ),
        ]),
        SizedBox(
          height: 140,
          child: Row(
            children: [
              Expanded(
                child: Consumer(builder: (context, ref, _) {
                  final file = ref.watch(_currentFile);
                  return file == null
                      ? const SizedBox.shrink()
                      : AppTitleWrapper(
                          title: 'Raw Image',
                          child: Expanded(
                            child: Image.file(file, fit: BoxFit.contain),
                          ),
                        );
                }),
              ),
              Expanded(
                child: Consumer(builder: (context, ref, _) {
                  return ref.watch(_currentImageItem).when(
                        data: (item) {
                          return item == null
                              ? const SizedBox.shrink()
                              : AppTitleWrapper(
                                  title: 'Blurhash Image',
                                  actions: [
                                    IconButton(
                                      onPressed: () async {
                                        final config = await getConfig(
                                          context: context,
                                          hash: item.blurHash.hash,
                                        );
                                        if (config == null) return;
                                        await save(config, context);
                                      },
                                      icon: const Icon(Icons.save_alt),
                                    ),
                                  ],
                                  child: Expanded(
                                    child: Center(
                                      child: AspectRatio(
                                        aspectRatio: item.aspectRatio,
                                        child: BlurHash(
                                          hash: item.blurHash.hash,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        },
                        error: (e, stack) => Text(e.toString()),
                        loading: () =>
                            const CircularProgressIndicator.adaptive(),
                      );
                }),
              ),
            ],
          ),
        ),
        Consumer(builder: (context, ref, _) {
          return ref.watch(_currentImageItem).when(
                data: (item) {
                  if (item == null) return const SizedBox.shrink();
                  return AppTitleWrapper(
                    title: 'blurhash',
                    actions: [
                      IconButton(
                        onPressed: () {
                          ClipboardUtil.copy(item.blurHash.hash);
                        },
                        icon: const Icon(Icons.copy),
                      )
                    ],
                    child: AppTextBox(data: item.blurHash.hash),
                  );
                },
                error: (e, stack) => Text(e.toString()),
                loading: () => const LinearProgressIndicator(),
              );
        }),
      ],
    );
  }
}
