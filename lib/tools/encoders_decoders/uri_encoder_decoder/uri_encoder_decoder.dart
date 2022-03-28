import 'package:alga/constants/import_helper.dart';
part './uri_provider.dart';

class UriEncoderDecoderView extends StatelessWidget {
  const UriEncoderDecoderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
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
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            RefReadonly(builder: (ref) {
              return IconButton(
                icon: const Icon(Icons.paste),
                onPressed: () async {
                  ref.read(_input).text = await ClipboardUtil.paste();
                  ref.refresh(_result);
                },
              );
            }),
            RefReadonly(builder: (ref) {
              return IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  ref.read(_input).clear();
                  ref.refresh(_result);
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
                ref.refresh(_result);
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
            return AppTextBox(
              maxLines: 12,
              minLines: 2,
              data: ref.watch(_result),
            );
          }),
        ),
      ],
    );
  }
}
