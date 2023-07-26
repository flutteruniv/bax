import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/localizations.dart';
import '../application/auth_service.dart';
import 'widgets/email_send_complete.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  static const name = 'signIn';
  static const route = '/signIn';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  String _email = '';

  StreamSubscription<PendingDynamicLinkData>? sub;

  @override
  void initState() {
    super.initState();
    sub = FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      await ref.watch(authServiceProvider).signWithCredentialByEmailLink(dynamicLinkData.link.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    sub?.cancel();
  }

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
          : Padding(
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
                        l.authenticate,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
