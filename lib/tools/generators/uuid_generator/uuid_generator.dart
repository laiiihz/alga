import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/refresh_button.dart';
import 'package:alga/ui/widgets/scaffold/tool_scaffold.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'package:uuid/uuid.dart';

import 'package:alga/utils/constants/import_helper.dart';

part './uuid_provider.dart';

class UUIDGeneratorRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UUIDGeneratorView();
  }
}

class UUIDGeneratorView extends StatefulWidget {
  const UUIDGeneratorView({super.key});

  @override
  State<UUIDGeneratorView> createState() => _UUIDGeneratorViewState();
}

class _UUIDGeneratorViewState extends State<UUIDGeneratorView> {
  @override
  Widget build(BuildContext context) {
    return ToolScaffold.scroll(
      title: Text(S.of(context).generatorUUID),
      body: Column(
        children: [
          ToolViewWrapper(
            children: [
              AlgaConfigSwitch(
                leading: const Icon(Icons.horizontal_rule),
                title: Text(S.of(context).hypens),
                value: _hypens,
              ),
              AlgaConfigSwitch(
                leading: const Icon(Icons.text_fields),
                title: Text(S.of(context).upperCase),
                value: _upperCase,
              ),
              ToolViewMenuConfig<UUIDVersion>(
                leading: const Icon(Icons.info_outline),
                title: Text(S.of(context).uuidVersion),
                subtitle: Text(S.of(context).uuidVersionDes),
                initialValue: (ref) => ref.watch(_version),
                items: UUIDVersion.values.map((e) {
                  return PopupMenuItem(
                    value: e,
                    child: Text(e.typeName(context)),
                  );
                }).toList(),
                onSelected: (version, ref) {
                  ref.read(_version.notifier).state = version;
                },
                name: (ref) => ref.watch(_version).typeName(context),
              ),
              Consumer(builder: (context, ref, _) {
                bool isV5 = ref.watch(_version) == UUIDVersion.v5;
                return AnimatedSize(
                  duration: kThemeAnimationDuration,
                  curve: Curves.easeInOutCubic,
                  child: isV5
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            children: [
                              ToolViewTextField(
                                width: 120,
                                title: Text(context.tr.uuidV5Name),
                                controller: _v5NameController,
                                onEditingComplete: (ref) =>
                                    ref.refresh(_v5Name),
                              ),
                              const SizedBox(height: 4),
                              ToolViewTextField(
                                expanded: true,
                                title: Text(context.tr.uuidV5Namespace),
                                controller: _v5NamespaceController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9a-fA-F/-]'),
                                  ),
                                ],
                                onEditingComplete: (ref) =>
                                    ref.refresh(_v5Namespace),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: ToolViewTextField(
                            title: Text(context.tr.uuidQuantity),
                            leading: const Icon(Icons.numbers_rounded),
                            controller: _countController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            hint: '1',
                            onEditingComplete: (ref) => ref.refresh(_count),
                          ),
                        ),
                );
              }),
            ],
          ),
          AppTitleWrapper(
            title: S.of(context).uuids,
            actions: [
              Consumer(
                builder: (context, ref, _) {
                  Widget next = TextButton.icon(
                    onPressed: () {
                      ref.read(_v5NamespaceController).text =
                          ref.read(_results);
                      ref
                          .read(_version.notifier)
                          .update((state) => UUIDVersion.v5);
                      ref.invalidate(_v5Namespace);
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('UUID v5'),
                  );
                  if (ref.watch(_version) == UUIDVersion.v5) {
                    next = const SizedBox.shrink();
                  }
                  if (ref.watch(_count) != 1) {
                    next = const SizedBox.shrink();
                  }
                  return AnimatedSize(
                    duration: kThemeAnimationDuration,
                    child: next,
                  );
                },
              ),
              CopyButtonWidget(refText: (ref) => ref.watch(_results)),
              Consumer(
                builder: (context, ref, _) {
                  final isV5 = ref.watch(_version) == UUIDVersion.v5;
                  return AnimatedSize(
                    duration: kThemeAnimationDuration,
                    curve: Curves.easeInOutCubic,
                    child: isV5
                        ? const SizedBox.shrink()
                        : RefreshButton(_results),
                  );
                },
              ),
            ],
            child: Consumer(builder: (context, ref, _) {
              return AppTextField(
                minLines: 2,
                maxLines: 20,
                text: ref.watch(_results),
              );
            }),
          ),
        ],
      ),
    );
  }
}
