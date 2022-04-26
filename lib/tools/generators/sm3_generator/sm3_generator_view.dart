import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/digests/sm3.dart';

import 'package:alga/constants/import_helper.dart';

part './sm3_generator_provider.dart';

class SM3GeneratorView extends StatelessWidget {
  const SM3GeneratorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).generatorSM3Hash),
      children: [
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            PasteButton(
              onPaste: (ref, value) {
                ref.watch(_inputController).text = value;
                ref.refresh(_inputValue);
              },
            ),
          ],
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              controller: ref.watch(_inputController),
              minLines: 1,
              maxLines: 12,
              onChanged: (_) {
                ref.refresh(_inputValue);
              },
            );
          }),
        ),
        const SizedBox(height: 8),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            CopyButton(
              onCopy: (ref) {
                final data = ref.read(_inputValue);
                return data;
              },
            ),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextBox(data: ref.watch(_inputValue));
          }),
        ),
      ],
    );
  }
}
