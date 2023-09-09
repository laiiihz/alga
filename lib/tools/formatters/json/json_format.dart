import 'package:alga/tools/formatters/json/json_format.provider.dart';
import 'package:alga/ui/widgets/error_message_expandable.dart';
import 'package:alga/ui/widgets/scaffold/tool_actions.dart';
import 'package:alga/ui/widgets/scaffold/tool_options.dart';
import 'package:alga/ui/widgets/scaffold/tool_scaffold.dart';
import 'package:alga/utils/constants/import_helper.dart';

class JsonFormatView extends ConsumerStatefulWidget {
  const JsonFormatView({super.key});

  @override
  ConsumerState<JsonFormatView> createState() => _JsonFormatViewState();
}

class _JsonFormatViewState extends ConsumerState<JsonFormatView> {
  @override
  Widget build(BuildContext context) {
    return ToolScaffold(
      title: Text(context.tr.formatterJson),
      options: [
        ToolOptionsEnum<JsonIndentType>(
          provider: jsonIndentProvider,
          title: Text(context.tr.indentation),
          leading: const Icon(Icons.format_indent_decrease),
          items: JsonIndentType.values,
          l10n: (context, value) => value.name(context),
          onSelect: (value) =>
              ref.read(jsonIndentProvider.notifier).change(value),
        ),
      ],
      body: ToolActions(
        childExpanded: true,
        actions: [
          if (ref.watch(jsonFormatLoadingProvider))
            const CircularProgressIndicator.adaptive(),
          const Spacer(),
          TextButton.icon(
            onPressed: () {
              ref.read(jsonContentProvider.notifier).format();
            },
            icon: const Icon(Icons.format_align_left_sharp),
            label: const Text('Format'),
          ),
        ],
        child: TextField(
          expands: true,
          minLines: null,
          maxLines: null,
          buildCounter: (
            context, {
            required int currentLength,
            required bool isFocused,
            int? maxLength,
          }) {
            final bf = StringBuffer();
            final controller = ref.read(jsonContentProvider);
            final select =
                (controller.selection.start - controller.selection.end).abs();
            if (select != 0) {
              bf.write(select);
              bf.write('/');
            }
            bf.write(currentLength);
            return Text(bf.toString());
          },
          decoration: InputDecoration(
            error: ErrorMessageWidget.get(ref.watch(errorMessageProvider)),
          ),
          controller: ref.watch(jsonContentProvider),
          textAlignVertical: TextAlignVertical.top,
        ),
      ),
    );
  }
}
