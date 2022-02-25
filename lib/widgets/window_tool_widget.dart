import 'dart:io';

import 'package:devtoys/widgets/titlebar_button.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

class WindowToolWidget extends StatelessWidget {
  final Widget child;
  const WindowToolWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget result = child;
    if (kIsWeb) return result;
    if (Platform.isAndroid || Platform.isIOS) return result;
    result = Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          top: 16,
          right: 16,
          child: const TitlebarButtonGroup(),
        ),
      ],
    );
    return result;
  }
}
