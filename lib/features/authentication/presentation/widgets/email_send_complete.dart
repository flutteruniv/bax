import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/localizations.dart';
import '../../../../configs/preferences.dart';
import '../../application/auth_service.dart';

class EmailSendComplete extends ConsumerWidget {
  const EmailSendComplete({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(localizationsProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.emailSentForVerification,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(l.verifyEmail),
            const SizedBox(height: 56),
            Text(l.ifEmailNotReceived, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('・'),
                Expanded(child: Text(l.checkSpamFolder)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('・'),
                Expanded(child: Text(l.setMailReception)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('・'),
                Expanded(child: Text('${l.checkEmailAddress} -> "${ref.read(preferencesProvider).getEmail()}"')),
              ],
            ),
            const SizedBox(height: 56),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(authServiceProvider).resetEmailSetting();
                },
                child: Text(
                  l.resetEmail,
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
