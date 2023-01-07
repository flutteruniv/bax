import 'package:bax/features/measurement_wifi/domain/wifi_measurement_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speed_test_dart/classes/server.dart';
import 'package:speed_test_dart/speed_test_dart.dart';

final wifiScannerProvider = FutureProvider((ref) {
  return WiFiScanner.initialize();
});

/// wifiの通信速度の計測やSSIDの特定などを行う
class WiFiScanner {
  WiFiScanner._(this._bestServers);

  static final _speedTeatDart = SpeedTestDart();
  static final _networkInfo = NetworkInfo();

  final List<Server> _bestServers;

  /// 測定にベストなサーバーを設定する
  static Future<List<Server>> _setBestServers() async {
    final settings = await _speedTeatDart.getSettings();
    // Russiaのサーバーからははじかれるためリストから取り除く
    final servers = settings.servers.where((element) => element.country != 'Russia').toList();
    return await _speedTeatDart.getBestServers(servers: servers);
  }

  /// 通信状況を確認する
  Future<String?> fetchSSID() async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isDenied) {
      return null;
    }
    return await _networkInfo.getWifiName();
  }

  /// wifiScanner のインスタンスを生成する
  static Future<WiFiScanner> initialize() async {
    final bestServers = await _setBestServers();
    return WiFiScanner._(bestServers);
  }

  /// インターネットの通信速度を Mbps で返す
  Future<WiFiMeasurementResult> measureInternetSpeed() async {
    final ssid = await fetchSSID();
    if (ssid == null) {
      throw Exception('No Connect WiFi');
    }
    final downloadSpeedMbps = (await _speedTeatDart.testDownloadSpeed(servers: _bestServers)) * 8;
    final uploadSpeedMbps = (await _speedTeatDart.testUploadSpeed(servers: _bestServers)) * 8;

    return WiFiMeasurementResult(
      downloadSpeedMbps: downloadSpeedMbps,
      uploadSpeedMbps: uploadSpeedMbps,
      ssid: ssid,
    );
  }
}
