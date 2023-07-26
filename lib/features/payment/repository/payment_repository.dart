import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../authentication/application/auth_service.dart';
import '../../user/application/user_service.dart';

final customerInfoProvider = StateProvider<CustomerInfo?>((ref) => null);
final paymentRepositoryProvider = Provider(PaymentRepository.new);

final isProProvider = Provider(
  (ref) {
    final user = ref.watch(loginUserProvider).valueOrNull;
    return user?.data()?.isPro == true || (ref.watch(customerInfoProvider)?.activeSubscriptions.isNotEmpty ?? false);
  },
);

final storeProductsProvider = FutureProvider(
  (ref) {
    return Purchases.getProducts(
      [ref.watch(productIdProvider)],
    );
  },
);

final priceStringProvider = FutureProvider(
  (ref) async => (await ref.watch(storeProductsProvider.future)).first.priceString,
);

final productIdProvider = Provider((ref) => 'bax_monthly_premium_plan');

class PaymentRepository {
  PaymentRepository(this.ref);
  final Ref ref;

  static const _androidAPIKey = 'goog_QlFVnrlvJvIyPZFegAQugcOytvh';
  static const _iOSAPIKey = 'appl_GUEhLBjxzWdSvnDkvGTcbGobmdT';
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
    return Purchases.purchaseProduct(ref.read(productIdProvider));
  }

  /// サブスクリプションを復元する
  Future<CustomerInfo> restorePurchases() async {
    final uid = ref.read(uidProvider).valueOrNull!;
    await Purchases.logIn(uid);
    return Purchases.restorePurchases();
  }
}

/// old
// static const _androidAPIKey = 'goog_LGBCtTpXecsHelnYUVJlEJXgqBi';
// static const _iOSAPIKey = 'appl_tOEvRcOONWfjFuHMmHZenhCBezI';