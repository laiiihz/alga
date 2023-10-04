import 'dart:convert';
import 'dart:typed_data';

import 'package:alga/ui/widgets/clear_button_widget.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';
import 'package:archive/archive.dart';

import 'package:alga/utils/constants/import_helper.dart';

part './gzip_compress_decompress_provider.dart';

class GzipCompressDecompressRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GzipCompressDecompressView();
  }
}

class GzipCompressDecompressView extends StatefulWidget {
  const GzipCompressDecompressView({super.key});

  @override
  State<GzipCompressDecompressView> createState() =>
      _GzipCompressDecompressViewState();
}

class _GzipCompressDecompressViewState
    extends State<GzipCompressDecompressView> {
  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
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
            PasteButtonWidget(
              _input,
              onUpdate: (ref) => ref.refresh(_inputText),
            ),
            ClearButtonWidget(
              _input,
              onUpdate: (ref) => ref.refresh(_inputText),
            ),
          ],
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              controller: ref.watch(_input),
              minLines: 2,
              maxLines: 12,
              onChanged: (_) => ref.refresh(_inputText),
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            CopyButtonWithText(_result),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(
              text: ref.watch(_result),
              minLines: 2,
              maxLines: 12,
            );
          }),
        ),
      ],
    );
  }
}
