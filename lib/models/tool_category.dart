import 'package:alga/constants/import_helper.dart';

abstract class CategoryBase {}

class ToolCategory extends CategoryBase {
  ToolCategory({
    required this.name,
  });
  final String Function(BuildContext context) name;
}

class CustomToolCategory extends CategoryBase {
  CustomToolCategory({
    required this.name,
  });
  final String name;
}
