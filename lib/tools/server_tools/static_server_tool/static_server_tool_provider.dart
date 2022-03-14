import 'dart:io';

import 'package:file_selector/file_selector.dart' as selector;
import 'package:flutter/material.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf/shelf_io.dart' as io;

const _kDefaultPort = 8080;

class StaticServerToolProvider extends ChangeNotifier {
  String? filePath;
  HttpServer? server;
  bool _listDirectories = false;
  bool get listDirectories => _listDirectories;
  set listDirectories(bool state) {
    _listDirectories = state;
    notifyListeners();
  }

  bool _accessOnNet = true;
  bool get accessOnNet => _accessOnNet;
  set accessOnNet(bool state) {
    _accessOnNet = state;
    notifyListeners();
  }

  final portController = TextEditingController();
  final pathController = TextEditingController();
  int get port {
    final _rawPort = int.tryParse(portController.text);
    if (_rawPort == null) {
      return _kDefaultPort;
    }
    if (_rawPort <= 0) {
      return _kDefaultPort;
    }
    if (_rawPort >= 65535) {
      return _kDefaultPort;
    }
    return _rawPort;
  }

  String? get _defaultPath {
    if (pathController.text.isEmpty) return null;
    return pathController.text;
  }

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
    final handler = createStaticHandler(
      filePath!,
      listDirectories: listDirectories,
      defaultDocument: _defaultPath,
    );
    server = await io.serve(
      handler,
      accessOnNet ? '0.0.0.0' : 'localhost',
      port,
    );
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
    portController.dispose();
    pathController.dispose();
    super.dispose();
  }
}
