import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MailAuthenticationPage extends ConsumerStatefulWidget {
  const MailAuthenticationPage({super.key});

  static const route = 'mail_authentication';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MailAuthenticationState();
}

class _MailAuthenticationState extends ConsumerState<MailAuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration.collapsed(hintText: 'メールアドレスを入力してください').copyWith(
                icon: const Icon(Icons.mail),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
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
