import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common_widgets/bax_indicator.dart';
import '../../bax/presentation/bax_history_page.dart';
import '../../map/presentation/facility_map_page.dart';
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
          return SingleChildScrollView(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('合計獲得BAX'),
                            Text(
                              '${user?.baxPoint}',
                              style: const TextStyle(
                                fontSize: 50,
                                height: 1.1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
