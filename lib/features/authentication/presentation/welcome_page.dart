import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../configs/urls.dart';
import '../../location/domain/my_location.dart';
import '../application/auth_service.dart';
import 'sign_in_page.dart';

class WelComePage extends ConsumerStatefulWidget {
  const WelComePage({super.key});

  static const name = 'welcome';
  static const route = '/welcome';

  @override
  ConsumerState<WelComePage> createState() => _WelComePageState();
}

class _WelComePageState extends ConsumerState<WelComePage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    ref.read(initLocationProvider);
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  children: const [
                    Center(
                      child: Text(
                        'BAX',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 80,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(48),
                        child: Text('BAXはWi-Fiの速度をみんなで測定して、Wi-Fiの速度が速い施設を探しやすくするためのアプリです。'),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(48),
                        child: Text('Wi-Fiを測定するとBAXというポイントが付与されます。BAXはAmazonギフト券などの特典に交換可能です。'),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(48),
                        child: Text('あなたの測定が、みんなの役に立ちます。ご協力よろしくお願いいたします。'),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var index = 0; index < 4; index++)
                    Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: index == currentIndex ? Colors.black : null,
                        shape: BoxShape.circle,
                        border: Border.all(),
                      ),
                    ),
                ],
              ),
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
                          onPressed: () {
                            launchUrl(Uri.parse(termOfServiceUrl));
                          },
                          child: const Text('利用規約'),
                        ),
                        TextButton(
                          onPressed: () {
                            launchUrl(Uri.parse(privacyPolicyUrl));
                          },
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
                      onPressed: () {
                        context.go(SignInPage.route);
                      },
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
