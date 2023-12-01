import 'package:flutter/material.dart';

class DeviceTile extends StatelessWidget {
  const DeviceTile({super.key, required this.title, required this.value});
  final String title;
  final String? value;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.primary.withOpacity(0.3),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              title,
              style:
                  TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 240),
                  child: Text(
                    value ?? '',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
