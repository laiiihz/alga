import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import 'package:alga/constants/import_helper.dart';

class DeviceInfoProvider {
  static const macos = 'macos';
  static const andrid = 'android';
  final _deviceInfo = DeviceInfoPlugin();
  BaseDeviceInfo? _currentInfo;
  Future<bool> init() async {
    switch (Platform.operatingSystem) {
      case 'macos':
        _currentInfo = await _deviceInfo.macOsInfo;
        return true;
      case 'android':
        _currentInfo = await _deviceInfo.androidInfo;
        return true;
      default:
        throw UnsupportedError('Unsupported platform');
    }
  }

  List<InfoModel> get infomations {
    if (_currentInfo == null) return [];
    switch (Platform.operatingSystem) {
      case macos:
        return InfoModel.fromMacos(_currentInfo as MacOsDeviceInfo);
      case andrid:
        return InfoModel.fromAndroid(_currentInfo as AndroidDeviceInfo);
      default:
        return [];
    }
  }

  List<InfoModel> commonInfomations = [
    InfoModel(
        title: (context) => S.of(context).localHostName,
        value: Platform.localHostname),
    InfoModel(
      title: (context) => S.of(context).numberOfProcessors,
      value: '${Platform.numberOfProcessors}',
    ),
    InfoModel(
        title: (context) => S.of(context).localeNameInfo,
        value: Platform.localeName),
    InfoModel(
      title: (context) => S.of(context).operatingSystem,
      value: Platform.operatingSystem,
    ),
    InfoModel(
      title: (context) => S.of(context).operatingSystemVersion,
      value: Platform.operatingSystemVersion,
    ),
  ];
}

class InfoModel {
  final IconData? icon;
  final String Function(BuildContext context) title;
  final String value;
  InfoModel({
    this.icon,
    required this.title,
    required this.value,
  });

  static List<InfoModel> fromMacos(MacOsDeviceInfo info) {
    return [
      InfoModel(title: (context) => 'Active CPUs', value: '${info.activeCPUs}'),
      InfoModel(title: (context) => 'Arch', value: info.arch),
      InfoModel(title: (context) => 'Computer Name', value: info.computerName),
      InfoModel(
          title: (context) => 'CPU Frequency', value: '${info.cpuFrequency}'),
      InfoModel(title: (context) => 'Host Name', value: info.hostName),
      InfoModel(
          title: (context) => 'Kernel Version', value: info.kernelVersion),
      InfoModel(title: (context) => 'Memory Size', value: '${info.memorySize}'),
      InfoModel(title: (context) => 'Model', value: info.model),
      InfoModel(title: (context) => 'OS Release', value: info.osRelease),
      InfoModel(
          title: (context) => 'System GUID', value: info.systemGUID ?? ''),
    ];
  }

  static List<InfoModel> fromAndroid(AndroidDeviceInfo info) {
    return [
      InfoModel(title: (context) => 'Board', value: info.board),
      InfoModel(title: (context) => 'Bootloader', value: info.bootloader),
      InfoModel(title: (context) => 'Brand', value: info.brand),
      InfoModel(title: (context) => 'Device', value: info.device),
      InfoModel(title: (context) => 'Display', value: info.display),
      InfoModel(title: (context) => 'Fingerprint', value: info.fingerprint),
      InfoModel(title: (context) => 'Hardware', value: info.hardware),
      InfoModel(title: (context) => 'Host', value: info.host),
      InfoModel(title: (context) => 'Id', value: info.id),
      InfoModel(
          title: (context) => 'Is Physical Device',
          value: '${info.isPhysicalDevice}'),
      InfoModel(title: (context) => 'Manufacturer', value: info.manufacturer),
      InfoModel(title: (context) => 'Model', value: info.model),
      InfoModel(title: (context) => 'Product', value: info.product),
      InfoModel(
          title: (context) => 'supported32BitAbis',
          value: info.supported32BitAbis.join(',')),
      InfoModel(
          title: (context) => 'supported64BitAbis',
          value: info.supported64BitAbis.join(',')),
      InfoModel(
          title: (context) => 'supportedAbis',
          value: info.supportedAbis.join(',')),
      InfoModel(title: (context) => 'tags', value: info.tags),
      InfoModel(title: (context) => 'type', value: info.type),
      InfoModel(title: (context) => 'baseOS', value: info.version.baseOS ?? ''),
      InfoModel(title: (context) => 'codename', value: info.version.codename),
      InfoModel(
          title: (context) => 'incremental', value: info.version.incremental),
      InfoModel(
          title: (context) => 'previewSdkInt',
          value: '${info.version.previewSdkInt}'),
      InfoModel(title: (context) => 'release', value: info.version.release),
      InfoModel(title: (context) => 'sdkInt', value: '${info.version.sdkInt}'),
      InfoModel(
          title: (context) => 'securityPatch',
          value: '${info.version.securityPatch}'),
      ...info.systemFeatures.map((e) {
        return InfoModel(title: (context) => 'feature', value: e);
      }).toList(),
    ];
  }
}
