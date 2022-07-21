import 'package:alga/constants/import_helper.dart';

part './tool_categories.dart';

abstract class CategoryBase {}

class ToolCategory extends CategoryBase {
  ToolCategory({
    required this.icon,
    required this.name,
  });
  final String Function(BuildContext context) name;
  final Widget icon;
}
