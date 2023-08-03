import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../configs/localizations.dart';
import '../../authentication/application/auth_service.dart';
import '../../authentication/presentation/email_authentication_page.dart';
import '../../authentication/presentation/welcome_page.dart';
import '../../bax/application/bax_service.dart';
import '../../bax/domain/bax.dart';
import '../../bax/domain/bax_reasons.dart';
import '../../bax/presentation/bax_history_page.dart';
import '../../payment/presentation/payment_dialog.dart';
import '../../payment/repository/payment_repository.dart';
import '../application/user_service.dart';
import '../data/user_repository.dart';
import '../domain/user.dart';

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  static const route = 'my_page';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  Widget build(BuildContext context) {
    final isPro = ref.watch(isProProvider);
    final l = ref.watch(localizationsProvider);
    final loginUser = ref.watch(loginUserProvider).valueOrNull;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.myPage),
        actions: [
          IconButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    content: Text(l.confirmLogout),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: Text(l.cancel),
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
                        child: Text(l.ok),
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
              if (isPro)
                const Text(
                  'BAX Pro',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                    child: Text(l.linkEmailAddress),
                  ),
                ),
              const SizedBox(height: 64),
              InkWell(
                onTap: () {
                  context.goNamed(BaxHistoryPage.name);
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
                    showDialog<void>(
                      context: context,
                      builder: (context) {
                        return const UseBaxDialog();
                      },
                    );
                  },
                  child: Text(l.use500BAX),
                ),
              ),
              const SizedBox(height: 64),
              DropdownButton<LType>(
                value: loginUser?.data()?.languageCode ?? LType.en,
                items: [
                  for (final e in LType.values)
                    DropdownMenuItem(
                      value: e,
                      child: Text(e.displayName),
                    )
                ],
                onChanged: (value) {
                  loginUser?.reference.set(
                    loginUser.data()?.copyWith(languageCode: value ?? LType.en) ??
                        User(languageCode: value ?? LType.en),
                  );
                },
              ),
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
    final l = ref.watch(localizationsProvider);
    return AlertDialog(
      content: Text(
        l.exchange500BAXForAmazonGift,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(l.later),
        ),
        TextButton(
          onPressed: ref.watch(canUseBax)
              ? () async {
                  final isPro = ref.read(isProProvider);
                  if (!isPro) {
                    PaymentDialog.showFullScreenDialog(context);
                    return;
                  }

                  final uid = ref.read(uidProvider);
                  if (uid == null) {
                    return;
                  }
                  await ref.read(userRepositoryProvider).giveBax(
                        Bax(
                          uid: uid,
                          baxReasons: [
                            ref.read(baxReasonsProvider).redeemForAmazonGiftCard,
                          ],
                        ),
                      );

                  if (!mounted) {
                    return;
                  }
                  await showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(l.exchangeCompleted),
                      );
                    },
                  );
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context).pop();
                }
              : null,
          child: Text(l.exchange),
        ),
      ],
    );
  }
}
