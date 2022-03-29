library flutter_js_wrapper;

export 'src/js_stub.dart'
    if (dart.library.io) 'src/not_web_wrapper.dart'
    if (dart.library.js) 'src/web_wrapper.dart';
