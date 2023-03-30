import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final customerInfoProvider = StateProvider<CustomerInfo?>((ref) => null);
final paymentRepositoryProvider = Provider(PaymentRepository.new);

final isProProvider = Provider((ref) => ref.watch(customerInfoProvider)?.activeSubscriptions.isNotEmpty ?? false);

class PaymentRepository {
  PaymentRepository(this.ref);
  final Ref ref;

  static const _androidProductId = 'bax_monthly_premium_plan:bax-monthly-premium-plan';
  static const _iOSProductId = 'bax_monthly_premium_plan';
  final productId = Platform.isAndroid ? _androidProductId : _iOSProductId;

  static const _androidAPIKey = 'goog_LGBCtTpXecsHelnYUVJlEJXgqBi';
  static const _iOSAPIKey = 'appl_tOEvRcOONWfjFuHMmHZenhCBezI';
  final apiKey = Platform.isAndroid ? _androidAPIKey : _iOSAPIKey;

  Future<void> initPlatformState() async {
    await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.info);
    await Purchases.configure(PurchasesConfiguration(apiKey));

    /// customerInfoの更新を監視
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      ref.read(customerInfoProvider.notifier).update((_) => customerInfo);
    });
  }

  /// サブスクリプションを開始する
  Future<CustomerInfo> purchaseSubscription() async {
    return Purchases.purchaseProduct(productId);
  }

  Future<CustomerInfo> restorePurchases() async {
    return Purchases.restorePurchases();
  }
}
