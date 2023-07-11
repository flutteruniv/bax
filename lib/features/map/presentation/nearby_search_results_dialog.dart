import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/map_service.dart';

class NearbySearchResultsDialog extends ConsumerWidget {
  const NearbySearchResultsDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nearbySearchResults = ref.watch(myNearbyFacilityProvider);
    return AlertDialog(
      title: const Center(child: Text('近くの施設を選択')),
      content: (nearbySearchResults?.results ?? []).isEmpty
          ? const Column(
              children: [
                Spacer(),
                CircularProgressIndicator(),
                Spacer(),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (nearbySearchResults?.results ?? []).map((e) {
                  return Card(
                    elevation: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop(e);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                e.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
