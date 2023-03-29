import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../authentication/application/auth_service.dart';
import '../../bax/presentation/bax_history_page.dart';
import '../../map/presentation/facility_map_page.dart';
import '../application/user_service.dart';

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  static const route = 'my_page';
  static const name = 'myPage';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text('ログアウトしますか？'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('しない'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await ref.read(authServiceProvider).logout();
                          if (!mounted) {
                            return;
                          }
                          context.go('/WelComePage');
                        },
                        child: const Text('する'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Icon(
                Icons.account_circle,
                size: 80,
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  context.go('${FacilityMapPage.route}${MyPage.route}/${BaxHistoryPage.route}');
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Text(
                      '${ref.watch(userBaxProvider)}',
                      style: const TextStyle(
                        fontSize: 50,
                        height: 1.1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.navigate_next,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
