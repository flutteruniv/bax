import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/map_service.dart';
import 'prediction_result_list.dart';
import 'search_text_form_field.dart';

class SearchFacilityDialog extends ConsumerStatefulWidget {
  const SearchFacilityDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchFacilityDialogState();
}

class _SearchFacilityDialogState extends ConsumerState<SearchFacilityDialog> {
  // TODO(kenta-wakasa): 何も検索していないときは近くの施設を出したい

  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    ref.read(commonSearchedFacilitiesNotifierProvider.notifier).fetchNearbyFacility();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchTextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  searchMode: true,
                  onFieldSubmitted: (_) {
                    ref.read(commonSearchedFacilitiesNotifierProvider.notifier).clear();
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 16),
                PredicationResultList(
                  onTap: (value) async {
                    await ref.read(selectedFacilityNotifierProvider.notifier).geocoding(
                          value.placeId,
                          value.name,
                          value.address,
                        );
                    if (!mounted) {
                      return;
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}