import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/auth_service.dart';
import 'widgets/email_send_complete.dart';

class EmailAuthenticationPage extends ConsumerStatefulWidget {
  const EmailAuthenticationPage({super.key});

  static const route = 'email_authentication';
  static const name = 'emailAuthentication';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmailAuthenticationState();
}

class _EmailAuthenticationState extends ConsumerState<EmailAuthenticationPage> {
  String _email = '';

  @override
  Widget build(BuildContext context) {
    final isSentEmail = ref.watch(isSentEmailStreamProvider).valueOrNull ?? false;
    // メール送信完了時点で空文字にする
    _email = isSentEmail ? '' : _email;

    return Scaffold(
      appBar: AppBar(),
      body: isSentEmail
          ? const EmailSendComplete()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    '本人確認のため、メールアドレスの連携をお願いします',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration.collapsed(hintText: 'メールアドレスを入力してください').copyWith(
                      icon: const Icon(Icons.mail),
                    ),
                    onChanged: (value) => _email = value,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(authServiceProvider).sendEmail(_email);
                    },
                    child: const Text(
                      '連携',
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
