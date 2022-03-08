import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/encoders_decoders/gzip_compress_decompress/gzip_compress_decompress_provider.dart';
import 'package:alga/widgets/app_title.dart';
import 'package:alga/widgets/tool_view.dart';
import 'package:alga/widgets/tool_view_config.dart';
import 'package:flutter/material.dart';

class GzipCompressDecompressView extends StatefulWidget {
  const GzipCompressDecompressView({Key? key}) : super(key: key);

  @override
  State<GzipCompressDecompressView> createState() =>
      _GzipCompressDecompressViewState();
}

class _GzipCompressDecompressViewState
    extends State<GzipCompressDecompressView> {
  final _provider = GzipCompressDecompressProvider();

  update() => setState(() {});

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
      title: const Text('GZip Compress/Decompress'),
      children: [
        ToolViewConfig(
          leading: const Icon(Icons.swap_horiz_sharp),
          title: Text(S.of(context).conversion),
          subtitle: Text(S.of(context).selectConversion),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _provider.isCompress
                  ? const Text('Compress')
                  : const Text('Decompress'),
              Switch(
                value: _provider.isCompress,
                onChanged: (state) {
                  _provider.isCompress = state;
                  _provider.swapData();
                },
              ),
            ],
          ),
        ),
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            IconButton(
              icon: const Icon(Icons.paste),
              onPressed: _provider.paste,
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _provider.clear,
            ),
          ],
          child: TextField(
            controller: _provider.inputController,
            minLines: 12,
            maxLines: 12,
            onChanged: (_) {
              _provider.convert();
            },
          ),
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: _provider.copy,
            ),
          ],
          child: TextField(
            controller: _provider.outputController,
            minLines: 12,
            maxLines: 12,
          ),
        ),
      ],
    );
  }
}
