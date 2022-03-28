import 'dart:convert';
import 'dart:typed_data';

import 'package:alga/constants/import_helper.dart';
import 'package:archive/archive.dart';

part './gzip_compress_decompress_provider.dart';

class GzipCompressDecompressView extends StatefulWidget {
  const GzipCompressDecompressView({Key? key}) : super(key: key);

  @override
  State<GzipCompressDecompressView> createState() =>
      _GzipCompressDecompressViewState();
}

class _GzipCompressDecompressViewState
    extends State<GzipCompressDecompressView> {
  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).encoderDecoderGzip),
      children: [
        ToolViewConfig(
          leading: const Icon(Icons.swap_horiz_sharp),
          title: Text(S.of(context).conversion),
          subtitle: Text(S.of(context).selectConversion),
          trailing: Consumer(builder: (context, ref, _) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ref.watch(_isCompress)
                    ? Text(S.of(context).compress)
                    : Text(S.of(context).decompress),
                Switch(
                  value: ref.watch(_isCompress),
                  onChanged: (state) {
                    ref.read(_isCompress.notifier).state = state;
                  },
                ),
              ],
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            RefReadonly(builder: (ref) {
              return IconButton(
                icon: const Icon(Icons.paste),
                onPressed: () async {
                  ref.watch(_input).text = await ClipboardUtil.paste();
                  ref.refresh(_result);
                },
              );
            }),
            RefReadonly(builder: (ref) {
              return IconButton(
                icon: const Icon(Icons.clear),
                onPressed: ref.watch(_input).clear,
              );
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              controller: ref.watch(_input),
              minLines: 2,
              maxLines: 12,
              onChanged: (_) {
                ref.refresh(_result);
              },
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            CopyButton(onCopy: (ref) => ref.read(_result)),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextBox(
              data: ref.watch(_result),
              minLines: 2,
              maxLines: 12,
            );
          }),
        ),
      ],
    );
  }
}
