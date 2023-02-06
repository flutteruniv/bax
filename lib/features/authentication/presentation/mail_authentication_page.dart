import 'package:bax/features/authentication/presentation/widgets/mail_send_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/auth_service.dart';

class MailAuthenticationPage extends ConsumerStatefulWidget {
  const MailAuthenticationPage({super.key});

  static const route = 'mail_authentication';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MailAuthenticationState();
}

class _MailAuthenticationState extends ConsumerState<MailAuthenticationPage> {
  String _email = '';

  @override
  Widget build(BuildContext context) {
    final isSentMail = ref.watch(isSentMailStreamProvider).valueOrNull ?? false;

    return Scaffold(
      appBar: AppBar(),
      body: isSentMail
          ? const MailSendComplete()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    '本人確認のため、メールアドレスの認証をお願いします',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration.collapsed(hintText: 'メールアドレスを入力してください').copyWith(
                      icon: const Icon(Icons.mail),
                    ),
                    onChanged: (value) => _email = value,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(authServiceProvider).sendMail(_email);
                    },
                    child: const Text(
                      '認証',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
