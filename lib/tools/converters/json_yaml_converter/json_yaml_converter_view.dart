import 'package:alga/ui/widgets/clear_button_widget.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/ui/widgets/paste_button_widget.dart';
import 'package:animations/animations.dart';

import 'package:alga/utils/constants/import_helper.dart';

import 'json_yaml_co_converter_provider.dart';

class JsonYamlConverterView extends ConsumerWidget {
  const JsonYamlConverterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jsonWidget = AppTitleWrapper(
      key: const ValueKey('json'),
      title: 'JSON',
      expand: !isSmallDevice(context),
      actions: [
        CustomIconButton(
          tooltip: context.tr.format,
          onPressed: () {
            ref.read(jsonCVTControllerProvider.notifier).format();
          },
          icon: const Icon(Icons.format_align_left_rounded),
        ),
        CopyButton2(jsonCVTControllerProvider),
        PasteButtonWidget(jsonCVTControllerProvider),
        ClearButtonWidget(jsonCVTControllerProvider),
      ],
      child: TextField(
        minLines: isSmallDevice(context) ? 12 : null,
        maxLines: isSmallDevice(context) ? 12 : null,
        textAlignVertical: TextAlignVertical.top,
        expands: !isSmallDevice(context),
        controller: ref.watch(jsonCVTControllerProvider),
        enabled: !ref.watch(jsonLoadingProvider),
        decoration: InputDecoration(
          errorText: ref.watch(jsonErrorProvider),
        ),
      ),
    );
    final yamlWidget = AppTitleWrapper(
      key: const ValueKey('yaml'),
      title: 'YAML',
      expand: !isSmallDevice(context),
      actions: [
        CustomIconButton(
          tooltip: context.tr.format,
          onPressed: () {
            ref.read(yamlCVTControllerProvider.notifier).format();
          },
          icon: const Icon(Icons.format_align_left_rounded),
        ),
        CopyButton2(yamlCVTControllerProvider),
        PasteButtonWidget(yamlCVTControllerProvider),
        ClearButtonWidget(yamlCVTControllerProvider),
      ],
      child: TextField(
        minLines: isSmallDevice(context) ? 12 : null,
        maxLines: isSmallDevice(context) ? 12 : null,
        expands: !isSmallDevice(context),
        textAlignVertical: TextAlignVertical.top,
        controller: ref.watch(yamlCVTControllerProvider),
        enabled: !ref.watch(yamlLoadingProvider),
        decoration: InputDecoration(
          errorText: ref.watch(yamlErrorProvider),
        ),
      ),
    );
    final type = ref.watch(jsonYamlTypeProvider);
    Widget currentChild;
    switch (type) {
      case JsonYamlType.json:
        currentChild = jsonWidget;
        break;
      case JsonYamlType.yaml:
        currentChild = yamlWidget;
        break;
    }

    if (isSmallDevice(context)) {
      return ScrollableToolView(
        title: Text(S.of(context).jsonYamlConverter),
        children: [currentChild],
      );
    } else {
      return ToolView(
        title: Text(S.of(context).jsonYamlConverter),
        actions: [
          SegmentedButton<JsonYamlType>(
            showSelectedIcon: false,
            segments: JsonYamlType.values
                .map((e) => ButtonSegment(
                      value: e,
                      label: Text(e.name),
                    ))
                .toList(),
            selected: {ref.watch(jsonYamlTypeProvider)},
            onSelectionChanged: (p0) {
              ref
                  .read(jsonYamlTypeProvider.notifier)
                  .update((state) => p0.first);
            },
          ),
          const SizedBox(width: 16),
        ],
        fab: FloatingActionButton(
          onPressed: ref.watch(processingProvider)
              ? null
              : () {
                  final state = ref.read(jsonYamlTypeProvider);
                  switch (state) {
                    case JsonYamlType.json:
                      ref
                          .read(jsonCVTControllerProvider.notifier)
                          .convert2yaml();
                      return;
                    case JsonYamlType.yaml:
                      ref
                          .read(yamlCVTControllerProvider.notifier)
                          .convert2json();
                      return;
                  }
                },
          child: ref.watch(processingProvider)
              ? const CircularProgressIndicator.adaptive()
              : const Icon(Icons.swap_horiz_rounded),
        ),
        content: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.scaled,
              fillColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: child,
              ),
            );
          },
          child: currentChild,
        ),
      );
    }
  }
}
