import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BoxBuilder<T> extends StatelessWidget {
  final Box<T> box;
  final Widget Function(BuildContext context, Box<T> box) builder;
  const BoxBuilder({Key? key, required this.box, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (BuildContext context, Box<T> box, _) {
        return builder(context, box);
      },
    );
  }
}
