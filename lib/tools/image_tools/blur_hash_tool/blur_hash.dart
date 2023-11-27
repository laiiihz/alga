import 'dart:io';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/image_tools/blur_hash_tool/blur_hash.provider.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/buttons/copy_button.dart';
import 'package:alga/ui/widgets/custom_icon_button.dart';
import 'package:alga/ui/widgets/tool_view_config.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/utils/extension/list_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class BlurHashRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BlurHashPage();
  }
}

class BlurHashPage extends StatefulWidget {
  const BlurHashPage({super.key});

  @override
  State<BlurHashPage> createState() => _BlurHashPageState();
}

class _BlurHashPageState extends State<BlurHashPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.tr.blurHashTool),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: context.tr.encode),
              Tab(text: context.tr.decode),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [EncodeView(), DecodeView()],
        ),
      ),
    );
  }
}

class EncodeView extends ConsumerStatefulWidget {
  const EncodeView({super.key});

  @override
  ConsumerState<EncodeView> createState() => _EncodeViewState();
}

class _EncodeViewState extends ConsumerState<EncodeView> {
  @override
  Widget build(BuildContext context) {
    final image = ref.watch(imageFileProvider);
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ToolViewConfig(
          title: Text(context.tr.imageToBlurhash),
          trailing: const Icon(Icons.arrow_forward),
          onPressed: _showPickType,
        ),
        if (image != null)
          Material(
            color: Theme.of(context).colorScheme.onInverseSurface,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: 128, maxWidth: 256),
                      child: Image.file(File(image.path)),
                    ),
                  ),
                  CustomIconButton(
                    tooltip: context.tr.clear,
                    color: Theme.of(context).colorScheme.error,
                    onPressed: () {
                      ref.read(imageFileProvider.notifier).clear();
                    },
                    icon: const Icon(Icons.delete_rounded),
                  ),
                ],
              ),
            ),
          ),
        ...ref.watch(blurHashTextProvider).when(
              data: (d) {
                if (d == null) return [];
                return [
                  AlgaToolbar(
                    actions: [
                      CopyButton(() => d.blurHash.hash),
                    ],
                  ),
                  AppTextField(text: d.blurHash.hash),
                  Center(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: 256, maxWidth: 256),
                      child: BlurHash(hash: d.blurHash.hash),
                    ),
                  ),
                ];
              },
              error: (e, s) => const [SizedBox()],
              loading: () =>
                  const [Center(child: CircularProgressIndicator.adaptive())],
            ),
      ].sep(const SizedBox(height: 8)),
    );
  }

  Future _showPickType() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Pick Image'),
          contentPadding: const EdgeInsets.all(16),
          children: <Widget>[
            if (Platform.isAndroid || Platform.isIOS)
              FilledButton.tonalIcon(
                onPressed: () => Navigator.of(context).pop(ImageSource.camera),
                label: const Text('Camera'),
                icon: const Icon(Icons.camera),
              ),
            FilledButton.tonalIcon(
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              label: const Text('Gallery'),
              icon: const Icon(Icons.image),
            ),
          ].sep(const SizedBox(height: 8)),
        );
      },
    );
    if (source == null) return;

    final file = await ImagePicker().pickImage(source: source);
    if (file == null) return;
    if (!mounted) return;

    ref.read(imageFileProvider.notifier).change(file);
  }
}

class DecodeView extends StatefulWidget {
  const DecodeView({super.key});

  @override
  State<DecodeView> createState() => _DecodeViewState();
}

class _DecodeViewState extends State<DecodeView> {
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = validateBlurHash(controller.text);
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        AppInput(
          controller: controller,
          decoration: InputDecoration(
            errorText: result.$2,
          ),
        ),
        if (result.$1)
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 256, maxWidth: 256),
              child: BlurHash(hash: controller.text),
            ),
          ),
      ].sep(const SizedBox(height: 8)),
    );
  }
}
