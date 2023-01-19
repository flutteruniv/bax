import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/auth_service.dart';

class WelComePage extends ConsumerWidget {
  const WelComePage({super.key});

  static const route = '/welcome';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              const Text(
                'BAX',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 80,
                ),
              ),
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 280,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('利用規約'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('プライバシーポリシー'),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await authService.anonymousLogin();
                      },
                      child: const Text('規約に同意してはじめる'),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('データを引き継ぐ'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
