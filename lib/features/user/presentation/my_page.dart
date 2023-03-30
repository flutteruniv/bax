import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../authentication/application/auth_service.dart';
import '../../authentication/presentation/email_authentication_page.dart';
import '../../authentication/presentation/welcome_page.dart';
import '../../bax/application/bax_service.dart';
import '../../bax/domain/bax.dart';
import '../../bax/domain/bax_reasons.dart';
import '../../bax/presentation/bax_history_page.dart';
import '../application/user_service.dart';
import '../data/user_repository.dart';

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
                builder: (dialogContext) {
                  return AlertDialog(
                    content: const Text('ログアウトしますか？\nメールアドレス未連携の場合、BAXはすべて失われます。'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text('しない'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(dialogContext).pop();
                          await ref.read(authServiceProvider).logout();
                          if (!mounted) {
                            return;
                          }
                          context.go(WelComePage.route);
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
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Icon(
                Icons.account_circle,
                size: 80,
              ),
              const SizedBox(height: 8),
              Text(
                ref.watch(authStateChangesProvider).valueOrNull?.email ?? '',
              ),
              if (ref.watch(authStateChangesProvider).valueOrNull?.isAnonymous ?? false)
                SizedBox(
                  width: 240,
                  child: OutlinedButton(
                    onPressed: () {
                      context.goNamed(EmailAuthenticationPage.name);
                    },
                    child: const Text('メールアドレスを連携'),
                  ),
                ),
              const SizedBox(height: 64),
              InkWell(
                onTap: () {
                  context.go(BaxHistoryPage.name);
                },
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          width: 24,
                        ),
                        Text(
                          '${ref.watch(userBaxProvider)}',
                          style: const TextStyle(
                            fontSize: 50,
                            height: 1.1,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Icon(
                            Icons.navigate_next,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 240,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const UseBaxDialog();
                      },
                    );
                  },
                  child: const Text('500 BAX を使う'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UseBaxDialog extends ConsumerStatefulWidget {
  const UseBaxDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UseBaxDialogState();
}

class _UseBaxDialogState extends ConsumerState<UseBaxDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
        '500BAXをAmazonギフト券に交換できます。事前にメールアドレスの連携が必要です。',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('あとで'),
        ),
        TextButton(
          onPressed: ref.watch(canUseBax)
              ? () async {
                  final uid = ref.read(uidProvider).valueOrNull;
                  if (uid == null) {
                    return;
                  }
                  await ref.read(userRepositoryProvider).giveBax(
                        Bax(
                          uid: uid,
                          baxReasons: [
                            BaxReasons.redeemForAmazonGiftCard,
                          ],
                        ),
                      );
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: Text('正常に完了しました。3営業日以内に連携済みのメールアドレスへギフトコードが送られます。しばらくお待ち下さい。'),
                      );
                    },
                  );
                  Navigator.of(context).pop();
                }
              : null,
          child: const Text('交換する'),
        ),
      ],
    );
  }
}
