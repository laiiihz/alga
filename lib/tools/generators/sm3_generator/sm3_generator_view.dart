import 'dart:convert';
import 'dart:typed_data';

import 'package:alga/ui/widgets/clear_button_widget.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';
import 'package:convert/convert.dart';
import 'package:pointycastle/digests/sm3.dart';

import 'package:alga/utils/constants/import_helper.dart';

part './sm3_generator_provider.dart';

class SM3GeneratorView extends StatelessWidget {
  const SM3GeneratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).generatorSM3Hash),
      children: [
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            PasteButtonWidget(
              _inputController,
              onUpdate: (ref) => ref.refresh(_inputText),
            ),
            ClearButtonWidget(
              _inputController,
              onUpdate: (ref) => ref.refresh(_inputText),
            ),
          ],
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              controller: ref.watch(_inputController),
              minLines: 1,
              maxLines: 12,
              onChanged: (_) => ref.refresh(_inputText),
            );
          }),
        ),
        const SizedBox(height: 8),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            CopyButtonWidget(refText: (ref) => ref.read(_inputValue)),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(text: ref.watch(_inputValue));
          }),
        ),
      ],
    );
  }
}
