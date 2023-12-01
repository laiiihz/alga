import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_info.provider.g.dart';

final networkInfo = NetworkInfo();
@riverpod
FutureOr<NetworkInfoWrapper> networkInfoWrapper(NetworkInfoWrapperRef ref) {
  ref.watch(connectivityProvider);
  return NetworkInfoWrapper.fetch();
}

@riverpod
Stream<ConnectivityResult> connectivity(ConnectivityRef ref) {
  return Connectivity().onConnectivityChanged;
}

class NetworkInfoWrapper {
  final String? wifiBSSID;
  final String? wifiName;
  final String? wifiIP;
  final String? wifiIPv6;
  final String? wifiSubmask;
  final String? wifiBroadcast;
  final String? wifiGatewayIP;

  NetworkInfoWrapper(
      {required this.wifiBSSID,
      required this.wifiName,
      required this.wifiIP,
      required this.wifiIPv6,
      required this.wifiSubmask,
      required this.wifiBroadcast,
      required this.wifiGatewayIP});

  static Future<NetworkInfoWrapper> fetch() async {
    final [
      String? wifiBSSID,
      String? wifiName,
      String? wifiIP,
      String? wifiIPv6,
      String? wifiSubmask,
      String? wifiBroadcast,
      String? wifiGatewayIP,
    ] = await Future.wait(
      [
        _try(networkInfo.getWifiBSSID),
        _try(networkInfo.getWifiName),
        _try(networkInfo.getWifiIP),
        _try(networkInfo.getWifiIPv6),
        _try(networkInfo.getWifiSubmask),
        _try(networkInfo.getWifiBroadcast),
        _try(networkInfo.getWifiGatewayIP),
      ],
    );

    return NetworkInfoWrapper(
      wifiBSSID: wifiBSSID,
      wifiName: wifiName,
      wifiIP: wifiIP,
      wifiIPv6: wifiIPv6,
      wifiSubmask: wifiSubmask,
      wifiBroadcast: wifiBroadcast,
      wifiGatewayIP: wifiGatewayIP,
    );
  }

  List<(String? value, String l10n)> content(BuildContext context) {
    return [
      (wifiBSSID, 'wifiBSSID'),
      (wifiName, 'wifiName'),
      (wifiIP, 'wifiIP'),
      (wifiIPv6, 'wifiIPv6'),
      (wifiSubmask, 'wifiSubmask'),
      (wifiBroadcast, 'wifiBroadcast'),
      (wifiGatewayIP, 'wifiGatewayIP'),
    ];
  }
}

Future<String?> _try(Future<String?> Function() func) async {
  try {
    return await func();
  } catch (e) {
    return null;
  }
}
