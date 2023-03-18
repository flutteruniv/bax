import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            ListTile(
              title: Text("Bax履歴"),
              subtitle: Text("残り: 200bax"),
              tileColor: Colors.white,
              onTap: () {},
            ),
            const Divider(
              height: _dividerHeight,
            ),
          ],
        ),
      ),
    );
  }
}

/// 区切り線の高さ
const _dividerHeight = 1.0;
