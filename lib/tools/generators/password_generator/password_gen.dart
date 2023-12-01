import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/buttons/refresh_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'password_gen.provider.dart';

final useUppercase =
    booleanConfigProvider(const ValueKey('upperCase'), defaultValue: true);
final useLowercase =
    booleanConfigProvider(const ValueKey('lowerCase'), defaultValue: true);
final useDigit =
    booleanConfigProvider(const ValueKey('digit'), defaultValue: true);
final useSpecial =
    booleanConfigProvider(const ValueKey('special'), defaultValue: true);
final useCount =
    intConfigProvider(const ValueKey('passCount'), defaultValue: 16);

class PasswordGenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PasswordGenPage();
  }
}

class PasswordGenPage extends ConsumerStatefulWidget {
  const PasswordGenPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PasswordGenPageState();
}

class _PasswordGenPageState extends ConsumerState<PasswordGenPage> {
  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      title: Text(context.tr.passGenerator),
      configurations: [
        ConfigSwitch(
          title: Text(context.tr.passUppercaseCharacters),
          subtitle: const Text('[A-Z]'),
          value: useUppercase,
        ),
        ConfigSwitch(
          title: Text(context.tr.passLowercaseCharacters),
          subtitle: const Text('[a-z]'),
          value: useLowercase,
        ),
        ConfigSwitch(
          title: Text(context.tr.passNumbersCharacters),
          subtitle: const Text('[0-9]'),
          value: useDigit,
        ),
        ConfigSwitch(
          title: Text(context.tr.passSpecialCharacters),
          subtitle: const Text(r'!@#$%^&*'),
          value: useSpecial,
        ),
        ConfigNumber(
          title: Text(context.tr.passPasswordLength),
          value: useCount,
          min: 4,
        ),
      ],
      children: [
        AlgaToolbar(
          actions: [
            CopyButton(() => ref.read(resultsProvider)),
            RefreshButton(() => ref.invalidate(resultsProvider)),
          ],
        ),
        AppTextField(text: ref.watch(resultsProvider)),
      ],
    );
  }
}
