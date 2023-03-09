import 'dart:io';

import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/utils/image_util.dart';
import 'package:alga/ui/widgets/clear_button_widget.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

part 'blur_hash_tool_provider.dart';

class BlurHashToolView extends ConsumerStatefulWidget {
  const BlurHashToolView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BlurHashToolViewState();
}

class _BlurHashToolViewState extends ConsumerState<BlurHashToolView> {
  @override
  Widget build(BuildContext context) {
    final currentImage = ref.watch(currentFile);
    final hash = ref.watch(hashText);

    return ScrollableToolView(
      title: Text(context.tr.blurHashTool),
      children: [
        AppTitleWrapper(
          title: context.tr.configuration,
          child: ToolViewConfig(
            title: Text(context.tr.pickImage),
            onPressed: () async {
              final file = await ImageUtil.pick();
              if (file != null) {
                if (mounted) {
                  ref.read(currentFile.notifier).update((state) => file);
                }
              }
            },
          ),
        ),
        AppTitleWrapper(
          title: context.tr.blurhashToImage,
          actions: [
            PasteButtonWidget(
              hashController,
              onUpdate: (ref) => ref.refresh(hashText),
            ),
            ClearButtonWidget(
              hashController,
              onUpdate: (ref) => ref.refresh(hashText),
            ),
          ],
          child: TextField(
            controller: ref.watch(hashController),
            onEditingComplete: () => ref.refresh(hashText),
            onChanged: (value) => ref.refresh(hashText),
            inputFormatters: [
              //
              FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-Z0-9#\\$%*+,-.:;=?@\[\]^_{|}~]')),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (hash != null && hash.isNotEmpty)
          Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                  maxHeight: 400,
                ),
                child: BlurHash(hash: hash),
              ),
            ],
          ),
        const SizedBox(height: 8),
        AnimatedSize(
          duration: kThemeAnimationDuration,
          curve: Curves.easeInOutCubic,
          child: ref.watch(blurhashItem).when(
                data: (item) {
                  if (item == null) return const SizedBox.shrink();
                  return AppTitleWrapper(
                    title: context.tr.imageToBlurhash,
                    actions: [
                      CopyButtonWithText.raw(item.blurHash.hash),
                      CustomIconButton(
                        tooltip: context.tr.clear,
                        onPressed: () {
                          ref
                              .read(currentFile.notifier)
                              .update((state) => null);
                        },
                        icon: const Icon(Icons.clear_rounded),
                      ),
                    ],
                    child: AppTextField(text: item.blurHash.hash),
                  );
                },
                error: (error, stackTrace) => const SizedBox.shrink(),
                loading: () => const LinearProgressIndicator(),
              ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            if (currentImage != null)
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                  maxHeight: 400,
                ),
                child: Image.file(currentImage),
              ),
            ref.watch(blurhashItem).whenOrNull<Widget>(
                  data: (item) {
                    if (item == null) return const SizedBox.shrink();
                    return ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 400,
                        maxHeight: 400,
                      ),
                      child: AspectRatio(
                        aspectRatio: item.aspectRatio,
                        child: BlurHash(
                          hash: item.blurHash.hash,
                        ),
                      ),
                    );
                  },
                  //   error: (e, stack) => const Icon(Icons.warning),
                  //   loading: () => ConstrainedBox(
                  //     constraints: const BoxConstraints(
                  //       maxWidth: 400,
                  //       maxHeight: 400,
                  //     ),
                  //     child: Material(
                  //       color: Theme.of(context).colorScheme.primaryContainer,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       child: const Center(
                  //         child: CircularProgressIndicator.adaptive(),
                  //       ),
                  //     ),
                  //   ),
                ) ??
                const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
