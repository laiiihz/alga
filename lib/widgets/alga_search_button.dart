import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import '../l10n/l10n.dart';
import '../views/search_view/search_view.dart';

class AlgaSearchButton extends StatelessWidget {
  const AlgaSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {
        showSearch(context: context, delegate: AppSearchDelegate());
      },
      shape: StadiumBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 8),
          Text(S.of(context).search),
          const SizedBox(width: 8),
          Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              KeyModifier.alt.keyLabel,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text('S', style: Theme.of(context).textTheme.caption),
          ),
        ],
      ),
    );
  }
}
