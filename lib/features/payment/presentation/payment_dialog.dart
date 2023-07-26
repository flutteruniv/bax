import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../configs/localizations.dart';
import '../../../configs/logger.dart';
import '../../../configs/urls.dart';
import '../../load/application/loading_notifier.dart';
import '../repository/payment_repository.dart';

class PaymentDialog extends ConsumerStatefulWidget {
  const PaymentDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends ConsumerState<PaymentDialog> {
  @override
  Widget build(BuildContext context) {
    final l = ref.watch(localizationsProvider);
    final isPro = ref.watch(isProProvider);
    final priceString = ref.watch(priceStringProvider).valueOrNull ?? '   ';
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/bax_logo.svg',
                  width: 80,
                  color: Colors.black,
                ),
                const SizedBox(height: 8),
                const Text(
                  'BAX Pro',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$priceString/${l.month}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l.upgradingWillUnlockTheFollowingFeatures,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '・${l.textSearchForFacilities}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '・${l.useOfWiFiSpeedMap}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '・${l.earnDoublePoints}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '・${l.exchangePointsForRewards}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    ref.read(loadingProvider.notifier).show();

                    try {
                      await ref.read(paymentRepositoryProvider).purchaseSubscription();
                    } catch (e) {
                      logger.e(e);
                    } finally {
                      ref.read(loadingProvider.notifier).hide();
                    }
                  },
                  child: Text(l.oneWeekFreeTrial),
                ),
                Text(
                  '${l.billingAfterTrialEnds}\n${l.cancelAnytimeInSettings}',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 32),
                OutlinedButton(
                  onPressed: () async {
                    ref.read(loadingProvider.notifier).show();
                    try {
                      final res = await ref.read(paymentRepositoryProvider).restorePurchases();
                      if (res.activeSubscriptions.isEmpty) {
                        if (!mounted) {
                          return;
                        }
                        await showDialog<void>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(l.restoreFailed),
                            );
                          },
                        );
                      }
                    } catch (e) {
                      logger.e(e);
                    } finally {
                      ref.read(loadingProvider.notifier).hide();
                    }
                  },
                  child: Text(l.restorePurchase),
                ),
                const SizedBox(height: 32),
                Text(
                  l.agreeToBelowBeforeUse,
                  style: const TextStyle(fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // TODO(kenta-wakasa): 利用規約の多言語対応
                        launchUrl(Uri.parse(termOfServiceUrl));
                      },
                      child: Text(
                        l.terms,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO(kenta-wakasa): プライバシーポリシーの多言語対応
                        launchUrl(Uri.parse(privacyPolicyUrl));
                      },
                      child: Text(
                        l.privacy,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isPro)
            AlertDialog(
              content: const Text('ご購入ありがとうございます。引き続きBAXをお楽しみください。'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('戻る'),
                )
              ],
            ),
        ],
      ),
    );
  }
}
