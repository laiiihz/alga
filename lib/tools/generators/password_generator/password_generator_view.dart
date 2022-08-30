import 'dart:math';

import 'package:alga/constants/import_helper.dart';

part './password_generator_provider.dart';

class PasswordGeneratorView extends StatelessWidget {
  const PasswordGeneratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).passGenerator),
      children: [
        ToolViewConfig(
          title: Text(S.of(context).passUppercaseCharacters),
          subtitle: const Text('[A-Z]'),
          trailing: Consumer(builder: (context, ref, _) {
            return Switch(
              value: ref.watch(_useUppercase),
              onChanged: (state) {
                ref.watch(_useUppercase.notifier).state = state;
              },
            );
          }),
        ),
        ToolViewConfig(
          title: Text(S.of(context).passLowercaseCharacters),
          subtitle: const Text('[a-z]'),
          trailing: Consumer(builder: (context, ref, _) {
            return Switch(
              value: ref.watch(_useLowercase),
              onChanged: (state) {
                ref.watch(_useLowercase.notifier).state = state;
              },
            );
          }),
        ),
        ToolViewConfig(
          title: Text(S.of(context).passNumbersCharacters),
          subtitle: const Text('[0-9]'),
          trailing: Consumer(builder: (context, ref, _) {
            return Switch(
              value: ref.watch(_useNumbers),
              onChanged: (state) {
                ref.watch(_useNumbers.notifier).state = state;
              },
            );
          }),
        ),
        ToolViewConfig(
          title: Text(S.of(context).passSpecialCharacters),
          subtitle: const Text('[$_symbolBox]'),
          trailing: Consumer(builder: (context, ref, _) {
            return Switch(
              value: ref.watch(_useSymbols),
              onChanged: (state) {
                ref.watch(_useSymbols.notifier).state = state;
              },
            );
          }),
        ),
        ToolViewConfig(
          title: Text(S.of(context).passPasswordLength),
          trailing: Consumer(builder: (context, ref, _) {
            return SizedBox(
              width: 60,
              child: TextField(
                controller: ref.watch(_lengthCtr),
                onChanged: (_) {
                  ref.refresh(_useLength);
                },
              ),
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).passGeneratedPassword,
          actions: [
            Consumer(builder: (context, ref, _) {
              return IconButton(
                onPressed: () {
                  ref.refresh(_result);
                },
                icon: const Icon(Icons.refresh),
              );
            }),
            CopyButton(
              onCopy: (ref) {
                return ref.watch(_result);
              },
            ),
          ],
          child: Consumer(
            builder: (context, ref, _) {
              return AppTextField(text: ref.watch(_result));
            },
          ),
        ),
      ],
    );
  }
}
