import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/preferences.dart';
import '../../application/auth_service.dart';

class EmailSendComplete extends ConsumerWidget {
  const EmailSendComplete({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'メールアドレス受信確認用のメールを送信しました',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('メールをご確認いただき、メールに記載されたURLをクリックして、メール認証を完了してください。'),
          const SizedBox(height: 16),
          const Text('メールが届かない場合、以下をご確認ください。', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('・迷惑メールフォルダに入っていないかご確認ください。'),
          const Text('・「noreply@bax.network」からのメールを受け取れるように設定してください。'),
          Text('・ご使用のメールアドレス「${ref.read(preferencesProvider).getEmail()}」が正しいかどうか確認してください。'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(authServiceProvider).resetEmailSetting();
            },
            child: const Text(
              'メールアドレスを再設定',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
