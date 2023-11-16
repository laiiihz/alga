import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/buttons/help_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'date_parser.provider.dart';

final useCustomFormat = booleanConfigProvider(const Key('use_custom_format'));
final useCustomFormatContent = stringConfigProvider(const Key('custom_format'));

final useContent = stringConfigProvider(const Key('use_content'));

class DateParserPage extends ConsumerStatefulWidget {
  const DateParserPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DateParserPageState();
}

class _DateParserPageState extends ConsumerState<DateParserPage> {
  final _input = TextEditingController();
  @override
  void initState() {
    super.initState();
    _input.addListener(() {
      ref.read(useContent.notifier).change(_input.text);
    });
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      title: Text(context.tr.dateParser),
      configurations: [
        ConfigSwitch(
          title: const Text('Use Custom Format'),
          value: useCustomFormat,
        ),
        CrossFade(
          state: ref.watch(useCustomFormat),
          first: ConfigTextField(
            title: const Text('Custom Format'),
            provider: useCustomFormatContent,
            expanded: true,
          ),
        ),
      ],
      children: [
        AlgaToolbar(
          title: Text(context.tr.dateParserdate),
          actions: [
            HelpButton(
              onPressed: showSupportedDateFormatDialog,
              tooltip: context.tr.dateFormatHelp,
            ),
          ],
        ),
        TextField(controller: _input),
      ],
    );
  }

  Future<void> showSupportedDateFormatDialog() async {
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return AlertDialog(
          title: Text(context.tr.supportedDateFormat),
          content: Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                supportedDateFormat.map((e) => Chip(label: Text(e))).toList(),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(context.mtr.okButtonLabel),
            ),
          ],
        );
      },
    );
  }
}
