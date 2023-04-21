import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../authentication/application/auth_service.dart';

final customerInfoProvider = StateProvider<CustomerInfo?>((ref) => null);
final paymentRepositoryProvider = Provider(PaymentRepository.new);

final isProProvider = Provider((ref) => ref.watch(customerInfoProvider)?.activeSubscriptions.isNotEmpty ?? false);

class PaymentRepository {
  PaymentRepository(this.ref);
  final Ref ref;

  static const productId = 'bax_monthly_premium_plan';

  static const _androidAPIKey = 'goog_LGBCtTpXecsHelnYUVJlEJXgqBi';
  static const _iOSAPIKey = 'appl_tOEvRcOONWfjFuHMmHZenhCBezI';
  final apiKey = Platform.isAndroid ? _androidAPIKey : _iOSAPIKey;

  Future<void> initPlatformState() async {
    await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.info);
    await Purchases.configure(PurchasesConfiguration(apiKey));

    /// customerInfoの更新を監視
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      ref.read(customerInfoProvider.notifier).update((_) => customerInfo);
      final uid = ref.read(uidProvider).valueOrNull;
      if (uid == null) {
        return;
      }
      Purchases.logIn(uid);
    });
  }

  /// サブスクリプションを開始する
  Future<CustomerInfo> purchaseSubscription() async {
    final uid = ref.read(uidProvider).valueOrNull!;
    await Purchases.logIn(uid);
    return Purchases.purchaseProduct(productId);
  }

  /// サブスクリプションを復元する
  Future<CustomerInfo> restorePurchases() async {
    final uid = ref.read(uidProvider).valueOrNull!;
    await Purchases.logIn(uid);
    return Purchases.restorePurchases();
  }
}
