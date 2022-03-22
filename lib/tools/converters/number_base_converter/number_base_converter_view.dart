import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/clipboard_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part './number_base_converter_provider.dart';

class NumberBaseConverterView extends ConsumerWidget {
  const NumberBaseConverterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToolView.scrollVertical(
      title: Text(S.of(context).numberBaseConverter),
      children: ref.watch(_controllers).map((e) {
        return AppTitleWrapper(
          title: e.title(context),
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () => e.copy(),
            ),
          ],
          child: TextField(
            controller: e.controller,
            inputFormatters: e.formatter,
            minLines: 1,
            maxLines: 12,
            onChanged: (_) {
              NumberBaseUtil.update(e, ref.watch(_controllers));
            },
          ),
        );
      }).toList(),
    );
  }
}
