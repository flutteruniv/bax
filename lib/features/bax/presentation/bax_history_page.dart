import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common_widgets/bax_indicator.dart';
import '../application/bax_service.dart';

class BaxHistoryPage extends ConsumerStatefulWidget {
  const BaxHistoryPage({super.key});

  static const route = 'bax_history';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaxHistoryPageState();
}

class _BaxHistoryPageState extends ConsumerState<BaxHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bax履歴')),
      body: ref.watch(baxHistoriesProvider).when(
        data: (baxHistories) {
          return ListView.builder(
            itemCount: baxHistories.length,
            itemBuilder: (context, index) {
              final baxHistory = baxHistories[index];
              final dateTime = baxHistory.createdAt.dateTime;
              final createdAt = dateTime != null ? DateFormat('yyyy-MM-dd').format(dateTime) : '不明';
              return ListTile(
                title: Text('付与ポイント: ${baxHistory.totalPoint}bax'),
                subtitle: Text('付与日: $createdAt'),
              );
            },
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
