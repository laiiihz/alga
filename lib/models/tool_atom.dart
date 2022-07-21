import 'package:flutter/material.dart';

import 'package:alga/models/tool_category.dart';

class ToolAtom {
  ToolAtom({
    required this.widget,
    required this.icon,
    required this.name,
    required this.categories,
    this.platforms,
  });
  final Widget widget;
  final Widget icon;
  final String Function(BuildContext context) name;
  final List<ToolCategory> categories;
  final List<SupportPlatform>? platforms;
}

typedef SPlatform = SupportPlatform;

enum SupportPlatform {
  android,
  ios,
  linux,
  macos,
  windows,
  other,
}
