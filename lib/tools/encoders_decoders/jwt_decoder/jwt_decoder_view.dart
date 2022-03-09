import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/encoders_decoders/jwt_decoder/jwt_decoder_provider.dart';
import 'package:alga/tools/encoders_decoders/jwt_decoder/jwt_special_text_builder.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:language_textfield/language_textfield.dart';

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
            IconButton(
              icon: const Icon(Icons.paste),
              onPressed: _provider.paste,
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _provider.clear,
            ),
          ],
          child: Material(
            child: ExtendedTextField(
              controller: _provider.inputController,
              minLines: 3,
              maxLines: 12,
              onChanged: (_) {
                _provider.convert();
              },
              specialTextSpanBuilder: JWTSpecialTextBuilder(),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
        AppTitleWrapper(
          title: 'Header',
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: _provider.copyHeader,
            ),
          ],
          child: Material(
            child: LangTextField(
              lang: 'json',
              controller: _provider.headerController,
              minLines: 2,
              maxLines: 12,
              inputDecoration:
                  const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
        AppTitleWrapper(
          title: 'Payload',
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: _provider.copyPayload(),
            ),
          ],
          child: Material(
            child: LangTextField(
              lang: 'json',
              controller: _provider.payloadController,
              minLines: 2,
              maxLines: 12,
              inputDecoration:
                  const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
      ],
    );
  }
}
