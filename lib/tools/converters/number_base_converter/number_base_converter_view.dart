import 'package:flutter/services.dart';

import 'package:alga/utils/constants/import_helper.dart';

part './number_base_converter_provider.dart';

class NumberBaseConverterRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NumberBaseConverterView();
  }
}

class NumberBaseConverterView extends ConsumerWidget {
  const NumberBaseConverterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScrollableToolView(
      title: Text(S.of(context).numberBaseConverter),
      children: ref.watch(_controllers).map((e) {
        return ListTile(
          title: Text(e.title(context)),
          trailing: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () => e.copy(),
          ),
          subtitle: TextField(
            controller: e.controller,
            inputFormatters: e.formatter,
            minLines: 1,
            maxLines: 8,
            maxLength: e.maxLength,
            onChanged: (_) {
              NumberBaseUtil.update(e, ref.watch(_controllers));
            },
          ),
        );
      }).toList(),
    );
  }
}
