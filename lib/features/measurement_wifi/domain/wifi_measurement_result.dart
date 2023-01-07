/// WiFi速度の計測結果
class WiFiMeasurementResult {
  WiFiMeasurementResult({
    required this.downloadSpeedMbps,
    required this.uploadSpeedMbps,
    required this.ssid,
  });

  /// ダウンロードスピード（Mbps）
  final double downloadSpeedMbps;

  /// ダウンロードスピード（Mbps）
  final double uploadSpeedMbps;

  /// 接続していた SSID
  final String ssid;
}
