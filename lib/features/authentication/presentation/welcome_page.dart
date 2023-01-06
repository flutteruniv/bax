import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelComePage extends ConsumerWidget {
  const WelComePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onPressed: () {},
                child: const Text('規約に同意してはじめる'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('データを引き継ぐ'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
