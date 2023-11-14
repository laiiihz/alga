import 'package:alga/tools/generators/uuid_generator/uuid_gen.provider.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/buttons/refresh_button.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/copy_button_widget.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/utils/constants/import_helper.dart';

final hypens = booleanConfigProvider(const Key('hypens'), defaultValue: true);
final uppercase =
    booleanConfigProvider(const Key('uppercase'), defaultValue: true);
final uuidV5name = stringConfigProvider(const Key('uuidV5Name'));
final uuidV5namespace = stringConfigProvider(const Key('uuidV5Namespace'));
final uuidCounts = intConfigProvider(const Key('uuidCounts'));

class UUIDGenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UUIDGenPage();
  }
}

final class UUIDGenPage extends ConsumerStatefulWidget {
  const UUIDGenPage({super.key});

  @override
  ConsumerState<UUIDGenPage> createState() => _UUIDGenPageState();
}

class _UUIDGenPageState extends ConsumerState<UUIDGenPage> {
  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      title: Text(context.tr.generatorUUID),
      configurations: [
        ConfigSwitch(
          leading: const Icon(Icons.horizontal_rule),
          title: Text(context.tr.hypens),
          value: hypens,
        ),
        ConfigSwitch(
          leading: const Icon(Icons.text_fields),
          title: Text(context.tr.upperCase),
          value: uppercase,
        ),
        ConfigMenu<UUIDVersion>(
          leading: const Icon(Icons.info_outline),
          items: UUIDVersion.values,
          getName: (t) => t.getName(context),
          title: Text(context.tr.uuidVersion),
          initItem: ref.watch(uUIDVerProvider),
          onSelect: (t) {
            ref.read(uUIDVerProvider.notifier).change(t);
          },
        ),
        VisibleConfig(
          state: ref.watch(uUIDVerProvider) == UUIDVersion.v5,
          first: Column(
            children: [
              ConfigTextField(
                expanded: true,
                title: Text(context.tr.uuidV5Name),
                provider: uuidV5name,
              ),
              const SizedBox(height: 4),
              ConfigTextField(
                expanded: true,
                title: Text(context.tr.uuidV5Namespace),
                provider: uuidV5namespace,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.tr.emptyValue;
                  }
                  if (uuidRegexA.hasMatch(value) ||
                      uuidRegexB.hasMatch(value)) {
                    return null;
                  }
                  return context.tr.formatException;
                },
              ),
            ],
          ),
          second: ConfigNumber(
            title: Text(context.tr.uuidQuantity),
            value: uuidCounts,
          ),
        ),
      ],
      children: [
        AlgaToolbar(
          actions: [
            CrossFade(
              state: ref.watch(uUIDVerProvider) != UUIDVersion.v5 &&
                  ref.watch(uuidCounts) == 1,
              first: TextButton.icon(
                onPressed: () {
                  ref
                      .read(uuidV5namespace.notifier)
                      .change(ref.read(resultsProvider));

                  ref.read(uUIDVerProvider.notifier).change(UUIDVersion.v5);
                },
                label: const Text('V5'),
                icon: const Icon(Icons.arrow_forward, size: 16),
              ),
            ),
            CrossFade(
              state: ref.watch(uUIDVerProvider) != UUIDVersion.v5,
              first: RefreshButton(() {
                ref.invalidate(resultsProvider);
              }),
            ),
            CopyButtonWidget(
              refText: (ref) => ref.read(resultsProvider),
            ),
          ],
        ),
        AppTextField(text: ref.watch(resultsProvider)),
      ],
    );
  }
}
