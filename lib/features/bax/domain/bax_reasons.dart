import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/localizations.dart';
import 'bax_reason.dart';

final baxReasonsProvider = Provider((ref) {
  final l = ref.watch(localizationsProvider);
  return BaxReasons(l);
});

class BaxReasons {
  BaxReasons(this.l);
  final AppLocalizations l;

  /// Wi-Fi測定時の基礎ポイント
  late final measurementWifi = BaxReason(
    text: 'Wi-Fi${l.measure}',
    point: 10,
  );

  /// その施設に対して初の投稿の場合
  late final findingNewWiFi = BaxReason(
    text: l.newWifiSpot,
    point: 20,
  );

  /// Amazonギフト券交換
  late final redeemForAmazonGiftCard = BaxReason(
    text: l.amazonGiftCardExchange,
    point: -500,
  );
}
