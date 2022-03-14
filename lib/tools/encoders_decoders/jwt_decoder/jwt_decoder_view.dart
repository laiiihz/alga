import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/encoders_decoders/jwt_decoder/jwt_decoder_provider.dart';
import 'package:alga/tools/encoders_decoders/jwt_decoder/jwt_special_text_builder.dart';
import 'package:extended_text_field/extended_text_field.dart';

class JWTDecoderView extends StatefulWidget {
  const JWTDecoderView({Key? key}) : super(key: key);

  @override
  State<JWTDecoderView> createState() => _JWTDecoderViewState();
}

class _JWTDecoderViewState extends State<JWTDecoderView> {
  final _provider = JWTDecoderProvider();
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
      title: Text(S.of(context).decoderJWT),
      children: [
        AppTitleWrapper(
          title: 'JWT token',
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
          child: ExtendedTextField(
            controller: _provider.inputController,
            minLines: 3,
            maxLines: 12,
            onChanged: (_) {
              _provider.convert();
            },
            specialTextSpanBuilder: JWTSpecialTextBuilder(),
          ),
        ),
        AppTitleWrapper(
          title: S.of(context).jwtHeader,
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: _provider.copyHeader,
            ),
          ],
          child: AppTextBox(
            lang: LangHighlightType.json,
            data: _provider.headerResult,
            minLines: 2,
            maxLines: 12,
          ),
        ),
        AppTitleWrapper(
          title: S.of(context).jwtPayload,
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: _provider.copyPayload(),
            ),
          ],
          child: AppTextBox(
            lang: LangHighlightType.json,
            data: _provider.payloadResult,
            minLines: 2,
            maxLines: 12,
          ),
        ),
      ],
    );
  }
}
