import 'dart:convert';

import 'package:alga/ui/widgets/clear_button_widget.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';

import 'package:alga/utils/constants/import_helper.dart';
import 'package:language_textfield/lang_special_builder.dart';
// import 'package:alga/tools/encoders_decoders/jwt_decoder/jwt_special_text_builder.dart';

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
            PasteButtonWidget(
              _jwtInput,
              onUpdate: (ref) => ref.refresh(_jwtInputText),
            ),
            ClearButtonWidget(
              _jwtInput,
              onUpdate: (ref) => ref.refresh(_jwtInputText),
            ),
          ],
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              controller: ref.watch(_jwtInput),
              minLines: 3,
              maxLines: 12,
              onChanged: (_) => ref.refresh(_jwtInputText),
              // specialTextSpanBuilder: JWTSpecialTextBuilder(),
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).jwtHeader,
          actions: [
            CopyButtonWithText(_headerResult),
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
            CopyButtonWithText(_payloadResult),
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
