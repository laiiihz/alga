import 'dart:convert';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/buttons/clear_button.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:alga/utils/theme_util.dart';
import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:json2yaml/json2yaml.dart';
import 'package:language_textfield/lang_special_builder.dart';
import 'package:language_textfield/language_textfield.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:toml/toml.dart';
import 'package:yaml/yaml.dart';

part 'common_converter.g.dart';
part 'common_converter.provider.dart';

final _useContent = stringConfigProvider(const Key('content'));

class CommonConverterRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CommonConverterPage();
  }
}

class CommonConverterPage extends ConsumerStatefulWidget {
  const CommonConverterPage({super.key});

  static RichTextController of(BuildContext context) =>
      context.findAncestorStateOfType<_CommonConverterPageState>()!._controller;

  @override
  ConsumerState<CommonConverterPage> createState() =>
      _CommonConverterPageState();
}

class _CommonConverterPageState extends ConsumerState<CommonConverterPage> {
  final _controller = RichTextController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ref.read(_useContent.notifier).change(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isSmallDevice(context)
        ? const CommonConverterMobile()
        : const CommonConverterDesktop();
  }
}

class CommonConverterDesktop extends ConsumerWidget {
  const CommonConverterDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Common Converter'),
      ),
      body: const Row(
        children: [
          Expanded(child: ConverterInput()),
          Expanded(child: ConverterOutput()),
        ],
      ),
    );
  }
}

class CommonConverterMobile extends ConsumerStatefulWidget {
  const CommonConverterMobile({super.key});

  @override
  ConsumerState<CommonConverterMobile> createState() =>
      _CommonConverterMobileState();
}

class _CommonConverterMobileState extends ConsumerState<CommonConverterMobile> {
  bool showPreview = false;
  @override
  Widget build(BuildContext context) {
    ref.watch(_resultProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Common Converter'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showPreview = !showPreview;
              });
            },
            icon: const Icon(Icons.switch_access_shortcut_rounded),
          ),
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primary, secondary) {
          return SharedAxisTransition(
            animation: primary,
            secondaryAnimation: secondary,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        child: showPreview ? const ConverterOutput() : const ConverterInput(),
      ),
    );
  }
}

class ConverterInput extends ConsumerWidget {
  const ConverterInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = CommonConverterPage.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          AlgaToolbar(
            title: Text(context.tr.input),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => ConverterType.values
                    .map((e) => PopupMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                initialValue: ref.watch(inputTypeProvider),
                onSelected: (t) {
                  ref.read(inputTypeProvider.notifier).change(t);
                  controller.updateBuilder(LanguageBuilder.highlight(
                    ref.read(inputTypeProvider).highlighter,
                  ));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  child: Text(ref.watch(inputTypeProvider).name),
                ),
              ),
              PasteButton(controller: controller),
              ClearButton(controller: controller),
            ],
          ),
          Expanded(
            child: AppInput(
              expands: true,
              maxLines: null,
              controller: CommonConverterPage.of(context),
            ),
          ),
        ],
      ),
    );
  }
}

class ConverterOutput extends ConsumerWidget {
  const ConverterOutput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          AlgaToolbar(
            actions: [
              ref.watch(_resultProvider).whenOrNull(
                    data: (data) {
                      return CopyButton(() => data.$1);
                    },
                  ) ??
                  const SizedBox(),
              PopupMenuButton(
                itemBuilder: (context) => ConverterType.values
                    .map((e) => PopupMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                initialValue: ref.watch(outputTypeProvider),
                onSelected: (t) {
                  ref.read(outputTypeProvider.notifier).change(t);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  child: Text(ref.watch(outputTypeProvider).name),
                ),
              ),
            ],
          ),
          Expanded(
            child: ref.watch(_resultProvider).when(
                  data: (data) {
                    return AppTextField(
                      text: data.$1,
                      expands: true,
                      language: ref.watch(outputTypeProvider).highlighter,
                      decoration: InputDecoration(errorText: data.$2),
                    );
                  },
                  error: (e, s) => const SizedBox.shrink(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                ),
          ),
        ],
      ),
    );
  }
}
