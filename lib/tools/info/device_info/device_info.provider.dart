// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:alga/l10n/l10n.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_info.provider.g.dart';

final p = DeviceInfoPlugin();

@Riverpod(keepAlive: true)
FutureOr<AndroidDeviceInfo> androidInfo(AndroidInfoRef ref) async {
  return await p.androidInfo;
}

@Riverpod(keepAlive: true)
FutureOr<List<Part>> deviceInfoParts(DeviceInfoPartsRef ref) async {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return Part.fromAndroid(await ref.watch(androidInfoProvider.future));
    case TargetPlatform.fuchsia:
      throw UnimplementedError();
    case TargetPlatform.iOS:
      return Part.fromIos(await p.iosInfo);
    case TargetPlatform.linux:
      return Part.fromLinux(await p.linuxInfo);
    case TargetPlatform.macOS:
      return Part.fromMacos(await p.macOsInfo);
    case TargetPlatform.windows:
      return Part.fromWindows(await p.windowsInfo);
  }
}

class Part {
  final String Function(BuildContext context) title;
  final String? value;
  Part({
    required this.title,
    required this.value,
  });
  static List<Part> fromCommon() {
    return [
      Part(
          title: (context) => context.tr.localHostName,
          value: Platform.localHostname),
      Part(
        title: (context) => context.tr.numberOfProcessors,
        value: '${Platform.numberOfProcessors}',
      ),
      Part(
          title: (context) => context.tr.localeNameInfo,
          value: Platform.localeName),
      Part(
        title: (context) => context.tr.operatingSystem,
        value: Platform.operatingSystem,
      ),
      Part(
        title: (context) => context.tr.operatingSystemVersion,
        value: Platform.operatingSystemVersion,
      ),
    ];
  }

  static List<Part> fromAndroid(AndroidDeviceInfo info) {
    return [
      Part(title: (context) => 'codename', value: info.version.codename),
      Part(title: (context) => 'incremental', value: info.version.incremental),
      Part(
          title: (context) => 'previewSdkInt',
          value: info.version.previewSdkInt?.toString()),
      Part(title: (context) => 'release', value: info.version.release),
      Part(title: (context) => 'sdkInt', value: info.version.sdkInt.toString()),
      Part(
          title: (context) => 'securityPatch',
          value: info.version.securityPatch),
      Part(title: (context) => 'board', value: info.board),
      Part(title: (context) => 'bootloader', value: info.bootloader),
      Part(title: (context) => 'brand', value: info.brand),
      Part(title: (context) => 'device', value: info.device),
      Part(title: (context) => 'display', value: info.display),
      Part(title: (context) => 'fingerprint', value: info.fingerprint),
      Part(title: (context) => 'hardware', value: info.hardware),
      Part(title: (context) => 'host', value: info.host),
      Part(title: (context) => 'id', value: info.id),
      Part(title: (context) => 'manufacturer', value: info.manufacturer),
      Part(title: (context) => 'model', value: info.model),
      Part(title: (context) => 'product', value: info.product),
      Part(
          title: (context) => 'supported32BitAbis',
          value: info.supported32BitAbis.join(',')),
      Part(
          title: (context) => 'supported64BitAbis',
          value: info.supported64BitAbis.join(',')),
      Part(
          title: (context) => 'supportedAbis',
          value: info.supportedAbis.join(',')),
      Part(title: (context) => 'tags', value: info.tags),
      Part(title: (context) => 'type', value: info.type),
      Part(
          title: (context) => 'isPhysicalDevice',
          value: info.isPhysicalDevice.toString()),
      Part(
          title: (context) => 'widthPx',
          value: info.displayMetrics.widthPx.toString()),
      Part(
          title: (context) => 'heightPx',
          value: info.displayMetrics.heightPx.toString()),
      Part(
          title: (context) => 'xDpi',
          value: info.displayMetrics.xDpi.toString()),
      Part(
          title: (context) => 'yDpi',
          value: info.displayMetrics.yDpi.toString()),
      Part(title: (context) => 'serialNumber', value: info.serialNumber),
      ...info.systemFeatures
          .map((e) => Part(title: (context) => 'feature', value: e)),
    ];
  }

  static List<Part> fromMacos(MacOsDeviceInfo info) {
    return [
      Part(title: (context) => 'computerName', value: info.computerName),
      Part(title: (context) => 'hostName', value: info.hostName),
      Part(title: (context) => 'arch', value: info.arch),
      Part(title: (context) => 'model', value: info.model),
      Part(title: (context) => 'kernelVersion', value: info.kernelVersion),
      Part(title: (context) => 'osRelease', value: info.osRelease),
      Part(
          title: (context) => 'version',
          value:
              '${info.majorVersion}.${info.minorVersion}.${info.patchVersion}'),
      Part(title: (context) => 'activeCPUs', value: info.activeCPUs.toString()),
      Part(
          title: (context) => 'memorySize',
          value: ConvertUtil.memSize(info.memorySize)),
      Part(
          title: (context) => 'cpuFrequency',
          value: info.cpuFrequency.toString()),
      Part(title: (context) => 'systemGUID', value: info.systemGUID),
    ];
  }

  static List<Part> fromLinux(LinuxDeviceInfo info) {
    return [];
  }

  static List<Part> fromIos(IosDeviceInfo info) {
    return [];
  }

  static List<Part> fromWindows(WindowsDeviceInfo info) {
    return [
      Part(
        title: (context) => 'buildLab',
        value: info.buildLab,
      ),
      Part(
        title: (context) => 'computerName',
        value: info.computerName,
      ),
      Part(
        title: (context) => 'numberOfCores',
        value: info.numberOfCores.toString(),
      ),
      Part(
        title: (context) => 'systemMemoryInMegabytes',
        value: ConvertUtil.megaSize(info.systemMemoryInMegabytes),
      ),
      Part(
        title: (context) => 'userName',
        value: info.userName,
      ),
      Part(
        title: (context) => 'osVersion',
        value: '${info.majorVersion}.${info.minorVersion}+${info.buildNumber}',
      ),
      Part(
        title: (context) => 'platformId',
        value: info.platformId.toString(),
      ),
      Part(
        title: (context) => 'csdVersion',
        value: info.csdVersion.toString(),
      ),
      Part(
        title: (context) => 'servicePackMajor',
        value: info.servicePackMajor.toString(),
      ),
      Part(
        title: (context) => 'servicePackMinor',
        value: info.servicePackMinor.toString(),
      ),
      Part(
        title: (context) => 'suitMask',
        value: info.suitMask.toString(),
      ),
      Part(
        title: (context) => 'productType',
        value: info.productType.toString(),
      ),
      Part(
        title: (context) => 'reserved',
        value: info.reserved.toString(),
      ),
      Part(
        title: (context) => 'buildLab',
        value: info.buildLab,
      ),
      Part(
        title: (context) => 'buildLabEx',
        value: info.buildLabEx,
      ),
      Part(
        title: (context) => 'displayVersion',
        value: info.displayVersion,
      ),
      Part(
        title: (context) => 'editionId',
        value: info.editionId,
      ),
      Part(
        title: (context) => 'installDate',
        value: info.installDate.toString(),
      ),
      Part(
        title: (context) => 'productId',
        value: info.productId,
      ),
      Part(
        title: (context) => 'productName',
        value: info.productName,
      ),
      Part(
        title: (context) => 'registeredOwner',
        value: info.registeredOwner,
      ),
      Part(
        title: (context) => 'releaseId',
        value: info.releaseId,
      ),
      Part(
        title: (context) => 'deviceId',
        value: info.deviceId,
      ),
    ];
  }
}

abstract class ConvertUtil {
  static String megaSize(int size) {
    return '${size ~/ 1024}GB';
  }

  static String memSize(int size) {
    return '${size / 1024 / 1024 ~/ 1024}GB';
  }
}
