import 'package:alga/constants/import_helper.dart';

part './uri_provider.dart';

class UriEncoderDecoderView extends StatelessWidget {
  const UriEncoderDecoderView({super.key});
  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).encoderDecoderURL),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewConfig(
              leading: const Icon(Icons.swap_horiz_sharp),
              title: Text(S.of(context).conversion),
              subtitle: Text(S.of(context).selectConversion),
              trailing: Consumer(builder: (context, ref, _) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ref.watch(_isEncode)
                        ? Text(S.of(context).encode)
                        : Text(S.of(context).decode),
                    Switch(
                      value: ref.watch(_isEncode),
                      onChanged: (state) {
                        ref.read(_isEncode.notifier).state = state;
                      },
                    ),
                  ],
                );
              }),
            ),
            ToolViewMenuConfig<UriEncodeType>(
              leading: const Icon(Icons.link_rounded),
              title: Text(S.of(context).uriType),
              name: (ref) => ref.watch(_type).getName(context),
              items: UriEncodeType.values
                  .map((e) =>
                      PopupMenuItem(value: e, child: Text(e.getName(context))))
                  .toList(),
              onSelected: (state, ref) {
                ref.read(_type.notifier).update((_) => state);
              },
              initialValue: (ref) => ref.watch(_type),
            ),
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            PasteButton(onPaste: (ref, data) {
              ref.read(_input).text = data;
              return ref.refresh(_result);
            }),
            Consumer(builder: (context, ref, _) {
              return IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  ref.read(_input).clear();
                  return ref.refresh(_result);
                },
              );
            }),
          ],
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              maxLines: 12,
              minLines: 2,
              controller: ref.watch(_input),
              onChanged: (_) {
                return ref.refresh(_result);
              },
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: [
            CopyButton(onCopy: (ref) => ref.read(_result)),
          ],
          child: Consumer(builder: (context, ref, _) {
            return AppTextField(
              maxLines: 12,
              minLines: 2,
              text: ref.watch(_result),
            );
          }),
        ),
      ],
    );
  }
}
