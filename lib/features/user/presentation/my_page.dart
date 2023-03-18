import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/bax_indicator.dart';
import '../application/user_service.dart';

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  static const route = 'my_page';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('マイページ')),
      body: ref.watch(currentUserProvider).when(
        data: (user) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Bax履歴'),
                  subtitle: user != null ? Text('残り: ${user.baxPoint}bax') : const Text('Baxが付与されておりません'),
                  tileColor: Colors.white,
                  onTap: user != null
                      ? () {
                          /// TODO 履歴に遷移
                        }
                      : null,
                ),
                const Divider(
                  height: _dividerHeight,
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 80,
            color: Colors.white,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text('エラーが発生しました。\n時間を置いて再度お試しください。'),
            ),
          );
        },
        loading: () {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: BaxIndicator(),
          );
        },
      ),
    );
  }
}

/// 区切り線の高さ
const _dividerHeight = 1.0;
