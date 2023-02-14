import 'dart:convert';

import 'package:alga/widgets/clear_button_widget.dart';
import 'package:alga/widgets/copy_button_widget.dart';
import 'package:alga/widgets/custom_icon_button.dart';
import 'package:alga/widgets/paste_button_widget.dart';
import 'package:animations/animations.dart';
import 'package:json2yaml/json2yaml.dart' as json_2_yaml;
import 'package:yaml/yaml.dart';

import 'package:alga/constants/import_helper.dart';

import 'json_yaml_co_converter_provider.dart';

part './json_yaml_converter_provider.dart';

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
        controller: ref.watch(jsonCVTControllerProvider),
        textAlignVertical: TextAlignVertical.top,
        expands: !isSmallDevice(context),
      ),
    );
    final yamlWidget = AppTitleWrapper(
      key: const ValueKey('yaml'),
      title: 'YAML',
      expand: !isSmallDevice(context),
      actions: [
        CopyButton2(_yamlController),
        // PasteButtonWidget(_yamlController, onUpadate: (ref) => ref.refresh(),),
        ClearButtonWidget(_yamlController),
      ],
      child: TextField(
        minLines: isSmallDevice(context) ? 12 : null,
        maxLines: isSmallDevice(context) ? 12 : null,
        expands: !isSmallDevice(context),
        controller: ref.watch(yamlCVTControllerProvider),
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
      case JsonYamlType.loading:
        currentChild = const Center(
          child: CircularProgressIndicator(),
        );
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
        fab: FloatingActionButton(
          onPressed: () {
            ref.read(jsonYamlTypeProvider.notifier).update((state) {
              return state == JsonYamlType.json
                  ? JsonYamlType.yaml
                  : JsonYamlType.json;
            });
          },
          child: const Icon(Icons.swap_horiz_rounded),
        ),
        content: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.scaled,
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
