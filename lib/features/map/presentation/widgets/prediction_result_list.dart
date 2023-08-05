import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/map_service.dart';
import '../../domain/common_searched_facility.dart';

class PredicationResultList extends ConsumerStatefulWidget {
  const PredicationResultList({
    super.key,
    required this.onTap,
  });

  final void Function(CommonSearchedFacility) onTap;

  @override
  ConsumerState<PredicationResultList> createState() => _PredicationResultListState();
}

class _PredicationResultListState extends ConsumerState<PredicationResultList> {
  final controller = ScrollController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commonFacilities = ref.watch(commonSearchedFacilitiesNotifierProvider);
    if (commonFacilities.isNotEmpty) {
      return Container(
        height: 280,
        color: Colors.white,
        child: Scrollbar(
          controller: controller,
          thumbVisibility: true,
          child: ListView.builder(
            controller: controller,
            itemCount: commonFacilities.length,
            itemBuilder: (context, index) {
              final commonFacility = commonFacilities[index];
              return InkWell(
                onTap: () async {
                  widget.onTap.call(commonFacility);
                },
                child: SizedBox(
                  height: 56,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commonFacility.name,
                          maxLines: 1,
                        ),
                        Text(
                          commonFacility.address,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
