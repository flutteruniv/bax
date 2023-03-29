import 'bax_reason.dart';

class BaxReasons {
  BaxReasons._();

  /// Wi-Fi測定時の基礎ポイント
  static const measurementWifi = BaxReason(
    text: 'Wi-Fi測定',
    point: 10,
  );

  /// その施設に対して初の投稿の場合
  static const findingNewWiFi = BaxReason(
    text: '新Wi-Fiスポット発見',
    point: 50,
  );

  /// Amazonギフト券交換
  static const redeemForAmazonGiftCard = BaxReason(
    text: 'Amazonギフト券交換',
    point: -500,
  );
}
