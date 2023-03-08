import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

final wiFiScannerProvider = Provider(WiFiScanner.new);

final ssidProvider = FutureProvider.autoDispose(
  (ref) => ref.read(wiFiScannerProvider).fetchSSID(),
);

final networkInfoProvider = Provider((_) => NetworkInfo());

/// wifiの通信速度の計測やSSIDの特定などを行う
class WiFiScanner {
  WiFiScanner(this.ref);

  final Ref ref;

  /// 接続中のWiFiのSSIDを確認する
  Future<String?> fetchSSID() async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isDenied) {
      return null;
    }
    final wifiName = await ref.read(networkInfoProvider).getWifiName();
    // NOTE: Android端末ではwifi名の両端に "" がついてしまうので、取り除く。
    return wifiName?.replaceAll('"', '');
  }
}
