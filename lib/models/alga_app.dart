import 'package:flutter/material.dart';

typedef ContextBuilder<T> = T Function(BuildContext context);

abstract class AlgaApp {
  String title(BuildContext context);
  String description(BuildContext context);
  Widget get icon;
  String get path;

  final map = <int, AlgaApp>{};
}
