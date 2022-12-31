import 'package:flutter/services.dart';

import 'package:uuid/uuid.dart';

import 'package:alga/constants/import_helper.dart';

part './uuid_provider.dart';

class UUIDGeneratorView extends StatefulWidget {
  const UUIDGeneratorView({super.key});

  @override
  State<UUIDGeneratorView> createState() => _UUIDGeneratorViewState();
}

class _UUIDGeneratorViewState extends State<UUIDGeneratorView> {
  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).generatorUUID),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewSwitchConfig(
              leading: const Icon(Icons.horizontal_rule),
              title: Text(S.of(context).hypens),
              value: (ref) => ref.watch(_hypens),
              onChanged: (value, ref) {
                ref.read(_hypens.notifier).state = value;
              },
            ),
            ToolViewSwitchConfig(
              leading: const Icon(Icons.text_fields),
              title: Text(S.of(context).upperCase),
              value: (ref) => ref.watch(_upperCase),
              onChanged: (value, ref) {
                ref.read(_upperCase.notifier).state = value;
              },
            ),
            ToolViewConfig(
              leading: const Icon(Icons.info_outline),
              title: Text(S.of(context).uuidVersion),
              subtitle: Text(S.of(context).uuidVersionDes),
              trailing: Consumer(builder: (context, ref, _) {
                return DropdownButton<UUIDVersion>(
                  items: UUIDVersion.values.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e.typeName(context)),
                    );
                  }).toList(),
                  value: ref.watch(_version),
                  onChanged: (version) {
                    ref.read(_version.notifier).state =
                        version ?? UUIDVersion.v1;
                  },
                );
              }),
            ),
          ],
        ),
        Row(
          children: [
            Consumer(builder: (context, ref, _) {
              return ElevatedButton(
                child: Text(S.of(context).generateUUIDs),
                onPressed: () {
                  return ref.refresh(_results);
                },
              );
            }),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('X'),
            ),
            SizedBox(
              width: 100,
              child: Consumer(builder: (context, ref, _) {
                return TextField(
                  controller: ref.watch(_countController),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    return ref.refresh(_count);
                  },
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  ),
                );
              }),
            )
          ],
        ),
        AppTitle(
          title: S.of(context).uuids,
          actions: [
            CopyButton(onCopy: (ref) => ref.read(_resultValue)),
          ],
        ),
        Consumer(builder: (context, ref, _) {
          return AppTextField(
            minLines: 2,
            maxLines: 20,
            text: ref.watch(_resultValue),
          );
        }),
      ],
    );
  }
}
