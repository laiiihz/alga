import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitlebarButtonGroup extends StatefulWidget {
  const TitlebarButtonGroup({Key? key}) : super(key: key);

  @override
  State<TitlebarButtonGroup> createState() => _TitlebarButtonGroupState();
}

class _TitlebarButtonGroupState extends State<TitlebarButtonGroup> {
  bool _showIcons = false;
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      TitlebarButton(
        showIcon: _showIcons,
        child: const Icon(Icons.fullscreen),
        color: const Color(0xFF61C554),
        onPressed: () async {
          bool isFull = await windowManager.isFullScreen();
          await windowManager.setFullScreen(!isFull);
        },
      ),
      const SizedBox(width: 8),
      TitlebarButton(
        showIcon: _showIcons,
        child: const Icon(Icons.remove),
        color: const Color(0xFFF4BF4F),
        onPressed: () {
          windowManager.minimize();
        },
      ),
      const SizedBox(width: 8),
      TitlebarButton(
        showIcon: _showIcons,
        child: const Icon(Icons.close),
        color: const Color(0xFFEC6A5E),
        onPressed: () {
          windowManager.close();
        },
      ),
    ];

    /// TODO add padding when button place at top left of window
    // children = children.reversed.toList();

    return MouseRegion(
      onHover: (event) {
        _showIcons = true;
        setState(() {});
      },
      onExit: (event) {
        _showIcons = false;
        setState(() {});
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

class TitlebarButton extends StatefulWidget {
  final bool showIcon;
  final Widget child;
  final Color color;
  final VoidCallback onPressed;
  const TitlebarButton(
      {Key? key,
      required this.showIcon,
      required this.child,
      required this.color,
      required this.onPressed})
      : super(key: key);

  @override
  State<TitlebarButton> createState() => _TitlebarButtonState();
}

class _TitlebarButtonState extends State<TitlebarButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 20,
      minWidth: 20,
      padding: EdgeInsets.zero,
      shape: const StadiumBorder(),
      color: widget.color,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: widget.showIcon ? 1 : 0,
        child: IconTheme(
          data: const IconThemeData(
            size: 10,
            color: Colors.black54,
          ),
          child: widget.child,
        ),
      ),
      onPressed: widget.onPressed,
    );
  }
}
