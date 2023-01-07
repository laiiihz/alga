import 'dart:math';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/widgets/copy_button_widget.dart';
import 'package:alga/widgets/refresh_button.dart';

part './password_generator_provider.dart';

class PasswordGeneratorView extends StatelessWidget {
  const PasswordGeneratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).passGenerator),
      children: [
        ToolViewWrapper(
          children: [
            AlgaConfigSwitch(
              title: Text(S.of(context).passUppercaseCharacters),
              subtitle: const Text('[A-Z]'),
              value: _useUppercase,
            ),
            AlgaConfigSwitch(
              title: Text(S.of(context).passLowercaseCharacters),
              subtitle: const Text('[a-z]'),
              value: _useLowercase,
            ),
            AlgaConfigSwitch(
              title: Text(S.of(context).passNumbersCharacters),
              subtitle: const Text('[0-9]'),
              value: _useNumbers,
            ),
            AlgaConfigSwitch(
              title: Text(S.of(context).passSpecialCharacters),
              subtitle: const Text(r'!@#$%^&*'),
              value: _useSymbols,
            ),
            ToolViewTextField(
              title: Text(S.of(context).passPasswordLength),
              controller: _lengthCtr,
              hint: '8',
              onEditingComplete: (ref) => ref.refresh(_useLength),
            ),
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).passGeneratedPassword,
          actions: [
            CopyButtonWithText(_result),
            RefreshButton(_result),
          ],
          child: Consumer(
            builder: (context, ref, _) {
              return AppTextField(
                text: ref.watch(_result),
              );
            },
          ),
        ),
      ],
    );
  }
}
