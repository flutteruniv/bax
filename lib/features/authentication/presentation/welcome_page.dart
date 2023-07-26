import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../configs/localizations.dart';
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
    final l = ref.watch(localizationsProvider);

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
                  children: [
                    const Center(
                      child: Text(
                        'BAX',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 80,
                        ),
                      ),
                    ),
                    // TODO(kenta-wakasa): はやいWi-Fiを見つけている人のイメージをAIで作成する。
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(48),
                        child: Text(l.appDescription),
                      ),
                    ),
                    // TODO(kenta-wakasa): Wi-Fi測定がGiftに変わるイラストのイメージをAIで作成する。
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(48),
                        child: Text(l.earnBAXDescription),
                      ),
                    ),
                    // TODO(kenta-wakasa): 世界がハッピーになっているイメージ
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(48),
                        child: Text(l.measureContribution),
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
                          child: Text(l.terms),
                        ),
                        TextButton(
                          onPressed: () {
                            launchUrl(Uri.parse(privacyPolicyUrl));
                          },
                          child: Text(l.privacy),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await authService.anonymousLogin();
                      },
                      child: Text(l.agreeToTerms),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        context.go(SignInPage.route);
                      },
                      child: Text(l.transferData),
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
