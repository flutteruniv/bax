import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../configs/logger.dart';
import '../../../configs/urls.dart';
import '../repository/payment_repository.dart';

class PaymentDialog extends ConsumerStatefulWidget {
  const PaymentDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends ConsumerState<PaymentDialog> {
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    final isPro = ref.watch(isProProvider);
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
                  width: 120,
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
                const Text(
                  '¥500/月',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'アップグレードで次の機能が解放されます',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '・文字列による施設検索',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '・Wi-Fi速度マップの利用',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '・BAXと特典の交換',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isProcessing = true;
                    });

                    try {
                      await ref.read(paymentRepositoryProvider).purchaseSubscription();
                    } catch (e) {
                      logger.e(e);
                    } finally {
                      setState(() {
                        isProcessing = false;
                      });
                    }
                  },
                  child: const Text('1週間無料トライアル'),
                ),
                const Text(
                  'トライアル終了後 ¥500/月 課金されます。\n設定画面からいつでも中止できます。',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 40),
                OutlinedButton(
                  onPressed: () async {
                    await ref.read(paymentRepositoryProvider).restorePurchases();
                  },
                  child: const Text('以前購入された方はこちら'),
                ),
                const SizedBox(height: 40),
                const Text(
                  '下記に同意の上ご利用ください。',
                  style: TextStyle(fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(termOfServiceUrl));
                      },
                      child: const Text(
                        '利用規約',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse(privacyPolicyUrl));
                      },
                      child: const Text(
                        'プライバシーポリシー',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isPro)
            AlertDialog(
              content: const Text('購入ありがとうございます。引き続きBAXをお楽しみください。'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('戻る'),
                )
              ],
            ),
          if (isProcessing)
            Container(
              child: const Center(
                child: LinearProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
