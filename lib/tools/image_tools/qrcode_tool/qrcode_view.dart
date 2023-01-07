import 'package:alga/widgets/clear_button_widget.dart';
import 'package:alga/widgets/copy_button_widget.dart';
import 'package:alga/widgets/custom_icon_button.dart';
import 'package:alga/widgets/paste_button_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:alga/constants/import_helper.dart';

part './qrcode_provider.dart';

class QrcodeView extends StatefulWidget {
  const QrcodeView({super.key});

  @override
  State<QrcodeView> createState() => _QrcodeViewState();
}

class _QrcodeViewState extends State<QrcodeView> {
  @override
  Widget build(BuildContext context) {
    return ScrollableToolView(
      title: Text(S.of(context).qrCodeTool),
      children: [
        ToolViewWrapper(
          children: [
            ToolViewTextField(
              title: Text(S.of(context).qrVersion),
              width: 120,
              controller: _versionInput,
              hint: context.tr.qrAutoVersion,
              onEditingComplete: (ref) => ref.refresh(_version),
            ),
            ToolViewMenuConfig<int>(
              title: Text(S.of(context).errorCorrectionLevel),
              name: (ref) =>
                  QrErrorCorrectLevel.getName(ref.watch(_errorCorrectionLevel)),
              items: QrErrorCorrectLevel.levels
                  .map((e) => PopupMenuItem(
                        value: e,
                        child: Text(QrErrorCorrectLevel.getName(e)),
                      ))
                  .toList(),
              onSelected: (item, ref) {
                ref.read(_errorCorrectionLevel.notifier).state = item;
              },
              initialValue: (ref) => ref.watch(_errorCorrectionLevel),
            ),
            AlgaConfigSwitch(
              title: Text(S.of(context).qrGapless),
              value: _gapless,
            ),
          ],
        ),
        AppTitleWrapper(
          title: S.of(context).input,
          actions: [
            PasteButtonWidget(
              _input,
              onUpdate: (ref) => ref.refresh(_inputData),
            ),
            ClearButtonWidget(
              _input,
              onUpdate: (ref) => ref.refresh(_inputData),
            ),
          ],
          child: Consumer(builder: (context, ref, _) {
            return TextField(
              controller: ref.watch(_input),
              onChanged: (_) => ref.refresh(_inputData),
              minLines: 1,
              maxLines: 12,
            );
          }),
        ),
        AppTitleWrapper(
          title: S.of(context).output,
          actions: const [
            CustomIconButton(
              tooltip: 'export',
              onPressed: null,
              icon: Icon(Icons.save_alt_rounded),
            ),
          ],
          child: SizedBox(
            height: 300,
            child: Center(
              child: Consumer(builder: (context, ref, _) {
                return QrImage(
                  data: ref.watch(_inputData),
                  version: ref.watch(_version),
                  errorCorrectionLevel: ref.watch(_errorCorrectionLevel),
                  gapless: ref.watch(_gapless),
                  backgroundColor: Colors.transparent,
                  foregroundColor:
                      isDark(context) ? Colors.white : Colors.black,
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
