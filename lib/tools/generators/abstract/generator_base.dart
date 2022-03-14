import 'package:flutter/material.dart';

abstract class GeneratorBase extends ChangeNotifier {
  void generate();
  void clear();
}
