import 'package:flutter/material.dart';

@Deprecated('use riverpod')
abstract class GeneratorBase extends ChangeNotifier {
  void generate();
  void clear();
}
