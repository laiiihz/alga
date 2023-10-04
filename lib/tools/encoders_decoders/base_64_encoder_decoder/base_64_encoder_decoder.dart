import 'dart:convert';
import 'dart:io';

import 'package:alga/tools/encoders_decoders/base_64_encoder_decoder/base_64.provider.dart';
import 'package:alga/ui/widgets/clear_button_widget.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';
import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/utils/image_util.dart';
import 'package:flutter/foundation.dart';

part 'base64_file_picker.dart';

class Base64EncoderDecoderRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Base64EncoderDecoderView();
  }
}

class Base64EncoderDecoderView extends StatefulWidget {
  const Base64EncoderDecoderView({super.key});

  @override
  State<Base64EncoderDecoderView> createState() =>
      _Base64EncoderDecoderViewState();
}

class _Base64EncoderDecoderViewState extends State<Base64EncoderDecoderView> {
  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).encoderDecoderBase64),
      children: [
        ToolViewWrapper(
          children: [
            AlgaSwitch(
              leading: const Icon(Icons.swap_horiz_sharp),
              title: Text(S.of(context).conversion),
              subtitle: Text(S.of(context).selectConversion),
              value: (ref) => ref.watch(isEncodeProvider),
              onChanged: (ref, value) =>
                  ref.read(isEncodeProvider.notifier).update(value),
            ),
            AlgaSwitch(
              leading: const Icon(Icons.swap_horiz_sharp),
              title: Text(S.of(context).urlSafe),
              value: (ref) => ref.watch(urlSafeProvider),
              onChanged: (ref, value) =>
                  ref.read(urlSafeProvider.notifier).update(value),
            ),
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            Consumer(builder: (context, ref, _) {
              return _Base64ImageButton(ref: ref);
            }),
            PasteButtonWidget(inputControllerProvider),
            ClearButtonWidget(inputControllerProvider),
          ],
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              minLines: 2,
              maxLines: 12,
              controller: ref.watch(inputControllerProvider),
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            Consumer(builder: (context, ref, _) {
              return CopyButtonWithText.raw(ref.watch(resultProvider));
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(
              minLines: 2,
              maxLines: 12,
              text: ref.watch(resultProvider),
            );
          }),
        ),
      ],
    );
  }
}
