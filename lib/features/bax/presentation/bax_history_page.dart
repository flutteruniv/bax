import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../configs/localizations.dart';
import '../application/bax_service.dart';

class BaxHistoryPage extends ConsumerStatefulWidget {
  const BaxHistoryPage({super.key});

  static const route = 'bax_history';
  static const name = 'baxHistory';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaxHistoryPageState();
}

class _BaxHistoryPageState extends ConsumerState<BaxHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final bax = ref.watch(myBaxHistoriesProvider);
    final baxHistories = bax?.docs.map((e) => e.data()).toList() ?? [];
    final l = ref.watch(localizationsProvider);
    return Scaffold(
      appBar: AppBar(title: Text('BAX ${l.history}')),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: baxHistories.length,
        itemBuilder: (context, index) {
          final baxHistory = baxHistories[index];
          final dateTime = baxHistory.createdAt.dateTime;
          final createdAt = dateTime != null ? DateFormat('yyyy-MM-dd HH:mm').format(dateTime) : l.unknown;
          return baxHistory.totalPoint > 0
              ? ListTile(
                  title: Text(
                    '+${baxHistory.totalPoint}',
                  ),
                  subtitle: Text('${l.acquired}: $createdAt'),
                )
              : ListTile(
                  title: Text(
                    '${baxHistory.totalPoint}',
                  ),
                  subtitle: Text('${l.dateOfUse}: $createdAt'),
                );
        },
      ),
    );
  }
}
