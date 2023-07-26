import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/localizations.dart';
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

    final l = ref.watch(localizationsProvider);

    return Scaffold(
      appBar: AppBar(),
      body: isSentEmail
          ? const EmailSendComplete()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      l.verifyForConfirmation,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration.collapsed(hintText: l.enterEmail).copyWith(
                        icon: const Icon(Icons.mail),
                      ),
                      onChanged: (value) => _email = value,
                    ),
                    const SizedBox(height: 64),
                    SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        onPressed: () async {
                          await ref.read(authServiceProvider).sendEmail(_email);
                        },
                        child: Text(
                          l.link,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
