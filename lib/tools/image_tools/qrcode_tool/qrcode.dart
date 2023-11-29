import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:alga/l10n/l10n.dart';
import 'package:alga/tools/tools.provider.dart';
import 'package:alga/ui/widgets/app_progress.dart';
import 'package:alga/ui/widgets/app_show_menu.dart';
import 'package:alga/ui/widgets/app_snack_bar.dart';
import 'package:alga/ui/widgets/app_text_field.dart';
import 'package:alga/ui/widgets/configurations/configurations.dart';
import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/ui/widgets/toolbar/alga_toolbar.dart';
import 'package:alga/ui/widgets/toolbar/toolbar_paste.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path/path.dart' as p;

final useErrorLevel = intConfigProvider(const ValueKey('errorLevel'),
    defaultValue: QrErrorCorrectLevel.L);
final useAuto =
    booleanConfigProvider(const ValueKey('auto'), defaultValue: true);
final useLevel = intConfigProvider(const ValueKey('level'), defaultValue: 1);
final useGap =
    booleanConfigProvider(const ValueKey('gap'), defaultValue: false);

class QrCodeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const QrCodePage();
  }
}

class QrCodePage extends ConsumerStatefulWidget {
  const QrCodePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrCodePageState();
}

class _QrCodePageState extends ConsumerState<QrCodePage> {
  final _input = TextEditingController();
  final _screenShot = GlobalKey();
  @override
  void initState() {
    super.initState();
    _input.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      title: Text(context.tr.qrCodeTool),
      configurations: [
        ConfigMenu<int>(
          items: QrErrorCorrectLevel.levels,
          getName: (t) => QrErrorCorrectLevel.getName(t),
          title: Text(context.tr.errorCorrectionLevel),
          initItem: ref.watch(useErrorLevel),
          onSelect: (t) {
            ref.read(useErrorLevel.notifier).change(t);
          },
        ),
        ConfigSwitch(
          title: Text(context.tr.qrAutoVersion),
          value: useAuto,
        ),
        ConfigSwitch(
          title: Text(context.tr.qrGapless),
          value: useGap,
        ),
        CrossFade(
          state: !ref.watch(useAuto),
          first: ConfigNumber(
            title: Text(context.tr.qrVersion),
            min: 1,
            max: 40,
            value: useLevel,
          ),
        ),
      ],
      children: [
        AlgaToolbar(
          title: Text(context.tr.input),
          actions: [
            PasteButton(controller: _input),
          ],
        ),
        AppInput(maxLines: 2, controller: _input),
        const AlgaToolbar(),
        Align(
          alignment: Alignment.topLeft,
          child: AppCrossMenu(
            items: QrImageOperators.values,
            onSelected: (t) async {
              switch (t) {
                case QrImageOperators.screenshot:
                  if (Platform.isAndroid || Platform.isIOS) {
                    _mobileSave();
                  } else {
                    _desktopSave();
                  }
                default:
              }
            },
            getName: (t) => t.getName(context),
            child: RepaintBoundary(
              key: _screenShot,
              child: QrImageView(
                data: _input.text,
                size: 256,
                gapless: ref.watch(useGap),
                errorCorrectionLevel: ref.watch(useErrorLevel),
                version:
                    ref.watch(useAuto) ? QrVersions.auto : ref.watch(useLevel),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(8),
                embeddedImageEmitsError: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _mobileSave() async {
    if (!await Gal.requestAccess()) {
      if (context.mounted) {
        showSnackBar(context, context.tr.permissionDenied);
      }
      return;
    }
    await progress(() async {
      if (!mounted) return;
      final bytes = await _getQrBytes();
      if (bytes == null) return;
      await Gal.putImageBytes(bytes);
    });
    if (mounted) {
      showSnackBar(context, context.mtr.okButtonLabel);
    }
  }

  _desktopSave() async {
    final dir = await getDirectoryPath();
    if (dir == null) return;

    final result = await progress(() => _getQrBytes());
    if (result == null) return;

    final file =
        File(p.join(dir, 'qr_${DateTime.now().millisecondsSinceEpoch}.png'));
    file.writeAsBytes(result);
    if (mounted) showSnackBar(context, context.mtr.okButtonLabel);
  }

  Future<Uint8List?> _getQrBytes() async {
    final renderObj = _screenShot.currentContext?.findRenderObject();
    if (renderObj is RenderRepaintBoundary) {
      final imageRaw = await renderObj.toImage(
        pixelRatio: MediaQuery.devicePixelRatioOf(context),
      );
      final imageBytes = await imageRaw.toByteData(format: ImageByteFormat.png);
      if (imageBytes == null) return null;
      return imageBytes.buffer.asUint8List();
    }
    return null;
  }
}

enum QrImageOperators {
  screenshot,
  ;

  String getName(BuildContext context) {
    return switch (this) {
      screenshot => context.tr.saveImage,
    };
  }
}
