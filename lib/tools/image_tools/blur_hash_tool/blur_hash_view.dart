import 'dart:io';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/image_util.dart';
import 'package:alga/widgets/ref_readonly.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      title: const Text('Blur Hash Tool'),
      children: [
        ToolViewWrapper(children: [
          ToolViewConfig(
            leading: const Icon(Icons.image),
            title: const Text('Pick image'),
            trailing: RefReadonly(builder: (ref) {
              return TextButton(
                onPressed: () async {
                  await ref.read(_currentFile.notifier).pick();
                },
                child: const Text('Pick'),
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
                                  actions: const [],
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
                    actions: const [],
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
