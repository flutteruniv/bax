import 'package:bax/features/map/application/map_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/bax_indicator.dart';
import '../../data/map_repository.dart';

class PredicationResultList extends ConsumerWidget {
  const PredicationResultList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(predictionResultStreamProvider).when(
      data: (predictionResults) {
        if (predictionResults.isNotEmpty) {
          return ColoredBox(
            color: Colors.white,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: predictionResults.length,
              itemBuilder: (context, index) {
                final predictionResult = predictionResults[index];
                return ListTile(
                  title: Text(predictionResult.resultFormatting.name),
                  subtitle: Text(predictionResult.resultFormatting.address),
                  onTap: () async {
                    await ref
                        .read(mapServiceProvider)
                        .geocoding(predictionResult.placeId, predictionResult.resultFormatting.name);
                  },
                );
              },
            ),
          );
        } else {
          return Container(
            width: double.infinity,
            height: 56,
            color: Colors.white,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text('一致する検索結果がありません'),
            ),
          );
        }
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
    );
  }
}
