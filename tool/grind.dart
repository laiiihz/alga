import 'dart:io';

import 'package:cli_util/cli_logging.dart';
import 'package:grinder/grinder.dart';

Logger logger = Logger.standard(ansi: Ansi(true));
main(args) => grind(args);

@Task('setup app')
Future setup() async {
  await wait('get latest packages', () async {
    await Pub.getAsync();
  });
  await wait('generate l10n', () async {
    await Process.run('flutter', ['gen-l10n']);
  });
}

@Task()
clean() async {
  wait('flutter clean', () async {
    await Process.run('flutter', ['clean']);
  });
  defaultClean();
}

Future wait(String message, Future Function() runner) async {
  final progress = logger.progress(message);
  await runner();
  progress.finish(showTiming: true);
}
