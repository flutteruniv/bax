import 'package:flutter/material.dart';

import '../../map/domain/nearby_search_results/nearby_search_results.dart';

class NearbySearchResultsDialog extends StatelessWidget {
  const NearbySearchResultsDialog({
    super.key,
    required this.nearbySearchResults,
  });

  final NearbySearchResults nearbySearchResults;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: nearbySearchResults.results.map((e) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pop(e);
              },
              child: Text(e.name),
            );
          }).toList(),
        ),
      ),
    );
  }
}
