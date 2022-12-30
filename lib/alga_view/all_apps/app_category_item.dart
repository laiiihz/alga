import 'package:alga/models/app_category.dart';
import 'package:flutter/material.dart';

class AppCategoryItem extends StatelessWidget {
  const AppCategoryItem(
    this.category, {
    super.key,
    required this.selected,
    required this.onChanged,
  });

  AppCategoryItem.all({
    super.key,
    required this.selected,
    required this.onChanged,
  }) : category = AppCategory.allApps;

  final AppCategory category;
  final String? selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final bool active = selected == category.uuid;
    return InkResponse(
      onTap: active
          ? null
          : () {
              onChanged(category.uuid);
            },
      highlightShape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              category.icon,
              const SizedBox(width: 8),
              Text(
                category.name(context),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
