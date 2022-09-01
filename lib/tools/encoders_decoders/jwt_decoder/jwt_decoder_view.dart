import 'dart:convert';

import 'package:extended_text_field/extended_text_field.dart';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/tools/encoders_decoders/jwt_decoder/jwt_special_text_builder.dart';

part './jwt_decoder_provider.dart';

class JWTDecoderView extends StatefulWidget {
  const JWTDecoderView({super.key});

  @override
  State<JWTDecoderView> createState() => _JWTDecoderViewState();
}

class _JWTDecoderViewState extends State<JWTDecoderView> {
  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).decoderJWT),
      children: [
        AppTitleWrapper(
          title: 'JWT token',
          actions: [
            PasteButton(onPaste: (ref, data) {
              ref.read(_jwtInput).text = data;
              ref.refresh(_jwtModel);
            }),
            Consumer(builder: (context, ref, _) {
              return IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  ref.refresh(_jwtModel);
                },
              );
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return ExtendedTextField(
              controller: ref.watch(_jwtInput),
              minLines: 3,
              maxLines: 12,
              onChanged: (_) {
                ref.refresh(_jwtModel);
              },
              specialTextSpanBuilder: JWTSpecialTextBuilder(),
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).jwtHeader,
          actions: [
            CopyButton(onCopy: (ref) => ref.read(_headerResult)),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(
              lang: LangHighlightType.json,
              text: ref.watch(_headerResult),
              minLines: 2,
              maxLines: 12,
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).jwtPayload,
          actions: [
            CopyButton(onCopy: (ref) => ref.read(_payloadResult)),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(
              lang: LangHighlightType.json,
              text: ref.watch(_payloadResult),
              minLines: 2,
              maxLines: 12,
            );
          }),
        ),
      ],
    );
  }
}
