import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/encoders_decoders/base_64_encoder_decoder/base_64_provider.dart';

class Base64EncoderDecoderView extends StatefulWidget {
  const Base64EncoderDecoderView({Key? key}) : super(key: key);

  @override
  State<Base64EncoderDecoderView> createState() =>
      _Base64EncoderDecoderViewState();
}

class _Base64EncoderDecoderViewState extends State<Base64EncoderDecoderView> {
  final _provider = Base64Provider();

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
      title: Text(S.of(context).encoderDecoderBase64),
      children: [
        ToolViewWrapper(
          children: [
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
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            IconButton(
              icon: const Icon(Icons.paste),
              onPressed: () {
                _provider.paste();
              },
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _provider.clear();
              },
            ),
          ],
          child: TextField(
            minLines: 2,
            maxLines: 12,
            controller: _provider.inputController,
            onChanged: (text) {
              _provider.convert();
            },
          ),
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                _provider.paste();
              },
            ),
          ],
          child: AppTextBox(
            minLines: 2,
            maxLines: 12,
            data: _provider.base64Result,
          ),
        ),
      ],
    );
  }
}
