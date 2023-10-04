import 'package:alga/tools/formatters/dart/dart_format.provider.dart';
import 'package:alga/ui/widgets/error_message_expandable.dart';
import 'package:alga/ui/widgets/scaffold/tool_actions.dart';
import 'package:alga/ui/widgets/scaffold/tool_copy.dart';
import 'package:alga/ui/widgets/scaffold/tool_scaffold.dart';
import 'package:alga/utils/constants/import_helper.dart';

class DartFormatRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DartFormatView();
  }
}

class DartFormatView extends ConsumerStatefulWidget {
  const DartFormatView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DartFormatViewState();
}

class _DartFormatViewState extends ConsumerState<DartFormatView> {
  @override
  Widget build(BuildContext context) {
    return ToolScaffold(
      title: Text(context.tr.formatterDart),
      body: ToolActions(
        childExpanded: true,
        actions: [
          if (ref.watch(dartFormatLoadingProvider))
            const CircularProgressIndicator.adaptive(),
          const Spacer(),
          ToolCopy.icon(ref.watch(dartContentProvider)),
          FilledButton.tonalIcon(
            onPressed: () {
              ref.read(dartContentProvider.notifier).format();
            },
            icon: const Icon(Icons.format_indent_decrease_rounded),
            label: Text(context.tr.format),
          ),
        ],
        child: TextField(
          expands: true,
          minLines: null,
          maxLines: null,
          onChanged: (value) {
            ref.read(errorMessageProvider.notifier).clear();
          },
          textAlignVertical: TextAlignVertical.top,
          controller: ref.watch(dartContentProvider),
          decoration: InputDecoration(
            error: ErrorMessageWidget.get(ref.watch(errorMessageProvider)),
          ),
        ),
      ),
    );
  }
}
