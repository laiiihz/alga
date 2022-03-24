part of './network_info_view.dart';

final _info = StateProvider.autoDispose<NetworkInfo>((ref) => NetworkInfo());

final _name = FutureProvider.autoDispose<InfoDetail>((ref) async => InfoDetail(
    title: (context) => S.of(context).networkName,
    value: await ref.watch(_info).getWifiName() ?? ''));

final _ssid = FutureProvider.autoDispose<InfoDetail>((ref) async => InfoDetail(
    title: (context) => S.of(context).networkSSID,
    value: await ref.watch(_info).getWifiBSSID() ?? ''));

final _ip = FutureProvider.autoDispose<InfoDetail>((ref) async => InfoDetail(
    title: (context) => S.of(context).networkIp,
    value: await ref.watch(_info).getWifiIP() ?? ''));

final _ip6 = FutureProvider.autoDispose<InfoDetail>((ref) async => InfoDetail(
    title: (context) => S.of(context).networkIPv6,
    value: await ref.watch(_info).getWifiIPv6() ?? ''));

final _submask = FutureProvider.autoDispose<InfoDetail>((ref) async =>
    InfoDetail(
        title: (context) => S.of(context).networkSubmask,
        value: await ref.watch(_info).getWifiSubmask() ?? ''));

final _broadcast = FutureProvider.autoDispose<InfoDetail>((ref) async =>
    InfoDetail(
        title: (context) => S.of(context).networkBroadcast,
        value: await ref.watch(_info).getWifiBroadcast() ?? ''));

final _gateway = FutureProvider.autoDispose<InfoDetail>((ref) async =>
    InfoDetail(
        title: (context) => S.of(context).networkGateway,
        value: await ref.watch(_info).getWifiGatewayIP() ?? ''));

final _infos = <AutoDisposeFutureProvider<InfoDetail>>[
  _name,
  _ssid,
  _ip,
  _ip6,
  _submask,
  _broadcast,
  _gateway,
];

class InfoDetail {
  final String Function(BuildContext context) title;
  final String value;
  InfoDetail({
    required this.title,
    required this.value,
  });
}
