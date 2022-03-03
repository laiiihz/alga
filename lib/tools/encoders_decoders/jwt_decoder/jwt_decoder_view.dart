import 'package:devtoys/constants/import_helper.dart';
import 'package:devtoys/tools/encoders_decoders/jwt_decoder/jwt_decoder_provider.dart';

class JWTDecoderView extends StatefulWidget {
  const JWTDecoderView({Key? key}) : super(key: key);

  @override
  State<JWTDecoderView> createState() => _JWTDecoderViewState();
}

class _JWTDecoderViewState extends State<JWTDecoderView> {
  final _provider = JWTDecoderProvider();

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: const Text('JWT Decoder'),
      children: [
        AppTitleWrapper(
          title: 'JWT token',
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
          title: 'Header',
          actions: [
            Button(
              child: const Icon(FluentIcons.copy),
              onPressed: _provider.copyHeader,
            ),
          ],
          child: TextBox(
            controller: _provider.headerController,
            minLines: 12,
            maxLines: 12,
          ),
        ),
        AppTitleWrapper(
          title: 'Payload',
          actions: [
            Button(
              child: const Icon(FluentIcons.copy),
              onPressed: _provider.copyPayload(),
            ),
          ],
          child: TextBox(
            controller: _provider.payloadController,
            minLines: 12,
            maxLines: 12,
          ),
        ),
      ],
    );
  }
}
