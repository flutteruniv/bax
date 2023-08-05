import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/localizations.dart';
import '../../application/map_service.dart';

class SearchTextFormField extends ConsumerStatefulWidget {
  const SearchTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.searchMode = false,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String)? onFieldSubmitted;

  final bool searchMode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchTextFormFieldState();
}

class _SearchTextFormFieldState extends ConsumerState<SearchTextFormField> {
  late bool searchMode = widget.searchMode;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      if (!widget.focusNode.hasFocus) {
        setState(() {
          searchMode = false;
        });
        ref.read(commonSearchedFacilitiesNotifierProvider.notifier).clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = ref.watch(localizationsProvider);
    return AnimatedContainer(
      width: searchMode ? MediaQuery.of(context).size.width : 56,
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(80),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: .1,
            color: Colors.grey,
          ),
        ],
      ),
      child: searchMode
          ? TextFormField(
              onFieldSubmitted: widget.onFieldSubmitted,
              controller: widget.controller,
              focusNode: widget.focusNode,
              autofocus: true,
              decoration: InputDecoration.collapsed(hintText: localizations.searchHear).copyWith(
                icon: const Icon(Icons.search),
              ),
              inputFormatters: [LengthLimitingTextInputFormatter(60)], // 一旦60文字で制限
              enableInteractiveSelection: true, // コピペ可
              onChanged: (value) => ref.read(commonSearchedFacilitiesNotifierProvider.notifier).searchFacilities(value),
            )
          : Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      searchMode = true;
                    });
                    ref.read(commonSearchedFacilitiesNotifierProvider.notifier).fetchNearbyFacility();
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
    );
  }
}
