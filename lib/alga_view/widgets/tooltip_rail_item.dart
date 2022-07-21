import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/material.dart';

class TooltipRailItem extends NavigationRailDestination {
  TooltipRailItem({
    required this.windowType,
    required Widget icon,
    required this.text,
  }) : super(
          label: Text(text),
          icon: windowType <= AdaptiveWindowType.small
              ? Tooltip(
                  message: text,
                  child: icon,
                )
              : icon,
        );

  final AdaptiveWindowType windowType;
  final String text;
}
