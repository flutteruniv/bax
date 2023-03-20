import 'package:flutter/material.dart';

import '../domain/nearby_search_results/nearby_search_results.dart';

class NearbySearchResultsDialog extends StatelessWidget {
  const NearbySearchResultsDialog({
    super.key,
    required this.nearbySearchResults,
  });

  final NearbySearchResults nearbySearchResults;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('近くの施設')),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: nearbySearchResults.results.map((e) {
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
