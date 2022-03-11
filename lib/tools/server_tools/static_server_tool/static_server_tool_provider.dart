import 'dart:io';

import 'package:file_selector/file_selector.dart' as selector;
import 'package:flutter/material.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf/shelf_io.dart' as io;

class StaticServerToolProvider extends ChangeNotifier {
  String? filePath;
  HttpServer? server;
  int port = 8080;
  bool get isStarted => server != null;
  Future<bool> openFile() async {
    final path = await selector.getDirectoryPath();
    if (path == null) return false;
    filePath = path;
    notifyListeners();
    return true;
  }

  startServe() async {
    if (filePath == null) return;
    if (server != null) return;
    final handler = createStaticHandler(filePath!, listDirectories: true);
    server = await io.serve(handler, '0.0.0.0', port);
    notifyListeners();
  }

  stop() async {
    server?.close();
    server = null;
    notifyListeners();
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
