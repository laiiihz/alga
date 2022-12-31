import 'dart:math';

import 'package:alga/constants/import_helper.dart';

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
            ToolViewSwitchConfig(
              title: Text(S.of(context).passUppercaseCharacters),
              subtitle: const Text('[A-Z]'),
              value: (ref) => ref.watch(_useUppercase),
              onChanged: (value, ref) =>
                  ref.watch(_useUppercase.notifier).state = value,
            ),
            ToolViewSwitchConfig(
              title: Text(S.of(context).passLowercaseCharacters),
              subtitle: const Text('[a-z]'),
              value: (ref) => ref.watch(_useLowercase),
              onChanged: (state, ref) {
                ref.watch(_useLowercase.notifier).state = state;
              },
            ),
            ToolViewSwitchConfig(
              title: Text(S.of(context).passNumbersCharacters),
              subtitle: const Text('[0-9]'),
              value: (ref) => ref.watch(_useNumbers),
              onChanged: (state, ref) {
                ref.watch(_useNumbers.notifier).state = state;
              },
            ),
            ToolViewSwitchConfig(
              title: Text(S.of(context).passSpecialCharacters),
              subtitle: const Text(r'!@#$%^&*'),
              value: (ref) => ref.watch(_useSymbols),
              onChanged: (state, ref) {
                ref.watch(_useSymbols.notifier).state = state;
              },
            ),
            ToolViewConfig(
              title: Text(S.of(context).passPasswordLength),
              trailing: Consumer(builder: (context, ref, _) {
                return SizedBox(
                  width: 60,
                  child: TextField(
                    controller: ref.watch(_lengthCtr),
                    decoration: const InputDecoration(hintText: '8'),
                    onChanged: (_) {
                      return ref.refresh(_useLength);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).passGeneratedPassword,
          actions: [
            Consumer(builder: (context, ref, _) {
              return IconButton(
                onPressed: () {
                  return ref.refresh(_result);
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
