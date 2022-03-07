import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/encoders_decoders/gzip_compress_decompress/gzip_compress_decompress_provider.dart';

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
          leading: const Icon(FluentIcons.switch_widget),
          title: Text(S.of(context).conversion),
          subtitle: Text(S.of(context).selectConversion),
          trailing: Row(
            children: [
              _provider.isCompress
                  ? const Text('Compress')
                  : const Text('Decompress'),
              ToggleSwitch(
                checked: _provider.isCompress,
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
            Button(
              child: const Icon(FluentIcons.paste),
              onPressed: _provider.paste,
            ),
            Button(
              child: const Icon(FluentIcons.clear),
              onPressed: _provider.clear,
            ),
          ],
          child: TextBox(
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
            Button(
              child: const Icon(FluentIcons.copy),
              onPressed: _provider.copy,
            ),
          ],
          child: TextBox(
            controller: _provider.outputController,
            minLines: 12,
            maxLines: 12,
          ),
        ),
      ],
    );
  }
}
