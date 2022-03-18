import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefReadonly extends StatelessWidget {
  final Widget Function(WidgetRef ref) builder;
  const RefReadonly({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) => builder(ref));
  }
}
