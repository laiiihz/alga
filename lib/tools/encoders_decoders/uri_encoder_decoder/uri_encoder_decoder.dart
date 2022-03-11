import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/encoders_decoders/uri_encoder_decoder/uri_provider.dart';

class UriEncoderDecoderView extends StatefulWidget {
  const UriEncoderDecoderView({Key? key}) : super(key: key);

  @override
  State<UriEncoderDecoderView> createState() => _UriEncoderDecoderViewState();
}

class _UriEncoderDecoderViewState extends State<UriEncoderDecoderView> {
  final _provider = UriProvider();
  update() {
    setState(() {});
  }

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
      title: Text(S.of(context).encoderDecoderURL),
      children: [
        AppTitle(title: S.of(context).configuration),
        ToolViewConfig(
          leading: const Icon(Icons.swap_horiz_sharp),
          title: Text(S.of(context).conversion),
          subtitle: Text(S.of(context).selectConversion),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _provider.isEncode
                  ? Text(S.of(context).encode)
                  : Text(S.of(context).decode),
              Switch(
                value: _provider.isEncode,
                onChanged: (state) {
                  _provider.isEncode = state;
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
              onPressed: () => _provider.paste(),
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => _provider.clear(),
            ),
          ],
          child: TextField(
            maxLines: 12,
            minLines: 2,
            controller: _provider.inputController,
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
              onPressed: () => _provider.copy(),
            ),
          ],
          child: TextField(
            maxLines: 12,
            minLines: 2,
            controller: _provider.outputController,
          ),
        ),
      ],
    );
  }
}
