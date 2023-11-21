import 'dart:io';

import 'package:cli_util/cli_logging.dart';
import 'package:grinder/grinder.dart';

Logger logger = Logger.standard(ansi: Ansi(true));
main(args) => grind(args);

@DefaultTask('setup app')
Future setup() async {
  TaskArgs args = context.invocation.arguments;
  bool noDep = args.getFlag('no-dep');
  await wait('get latest packages', () async {
    await Pub.getAsync();
  });
  await wait('generate l10n', () async {
    await Process.run('flutter', ['gen-l10n']);
  });
  await wait('generate dart files', () async {
    await Dart.runAsync('run', arguments: ['build_runner', 'build']);
  });
  if (!noDep) {
    await installDepApps();
  }
}

@Task('Install All nessary apps')
Future installDepApps() async {
  if (Platform.isMacOS) {
    if (await checkCliApp('pnpm')) {
      await installAppDmg('pnpm');
      await installDistributor();
      return;
    }

    if (await checkCliApp('npm')) {
      await installAppDmg('npm');
      await installDistributor();
      return;
    }

    throw Exception('npm or pnpm not found\n Please install Node first');
  }

  await installDistributor();

  // if (Platform.isMacOS) {
  //   await wait('install appdmg', () async {
  //     await Process.run('npm', ['install', '-g', 'appdmg']);
  //   });
  // }
}

Future installAppDmg(String package) async {
  if (!await checkCliApp('appdmg')) {
    await wait('install appdmg', () async {
      await Process.run(package, ['install', '-g', 'appdmg']);
    });
  }
}

Future installDistributor() async {
  if (!await checkCliApp('flutter_distributor')) {
    await wait('install flutter_distributor', () async {
      await Dart.runAsync('pub',
          arguments: ['global', 'activate', 'flutter_distributor']);
    });
  }
}

Future<bool> checkCliApp(String app) async {
  if (Platform.isLinux || Platform.isMacOS) {
    return wait('check $app installed', () async {
      final result = await Process.run('which', [app]);
      return result.exitCode == 0;
    });
  } else {
    return wait('check $app installed', () async {
      final result = await Process.run('which', [app]);
      return result.exitCode == 0;
    });
  }
}

@Task('build on Macos')
Future buildOnMac() async {
  TaskArgs args = context.invocation.arguments;
  final skip = args.getFlag('skip');

  installDistributor();

  await wait('build macos', () async {
    if (skip) stdout.write('[SKIP CLEAN]');
    await Process.run('flutter_distributor',
        ['release', '--name', 'macos', if (skip) '--skip-clean']);
  });

  await wait('build apk', () async {
    if (skip) stdout.write('[SKIP CLEAN]');
    await Process.run('flutter_distributor',
        ['release', '--name', 'android', if (skip) '--skip-clean']);
  });
}

@Task('Clean All generated artifacts')
clean() async {
  await wait('flutter clean', () async {
    await Process.run('flutter', ['clean']);
  });
  defaultClean();
}

Future<T> wait<T>(String message, Future<T> Function() runner) async {
  final progress = logger.progress(message);
  try {
    return await runner();
  } finally {
    progress.finish(showTiming: true);
  }
}
