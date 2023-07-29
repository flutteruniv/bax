import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/bax_indicator.dart';
import '../../../../configs/localizations.dart';
import '../../data/map_repository.dart';
import '../../domain/facility_prediction_results/facility_prediction_result.dart';

class PredicationResultList extends ConsumerWidget {
  const PredicationResultList({
    super.key,
    required this.onTap,
  });

  final void Function(FacilityPredictionResult) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(localizationsProvider);
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
                    onTap.call(predictionResult);
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
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(l.noMatchingResults),
            ),
          );
        }
      },
      error: (error, stackTrace) {
        return Container(
          width: double.infinity,
          height: 80,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(l.errorOccurred),
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
