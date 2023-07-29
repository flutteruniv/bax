import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/localizations.dart';
import '../../../payment/presentation/payment_dialog.dart';
import '../../../payment/repository/payment_repository.dart';
import '../../application/map_service.dart';

class SearchTextFormField extends ConsumerStatefulWidget {
  const SearchTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.searchMode = false,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = ref.watch(localeProvider).languageCode.split('_').first;
    final isPro = ref.watch(isProProvider);
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
              controller: widget.controller,
              focusNode: widget.focusNode,
              autofocus: true,
              decoration: InputDecoration.collapsed(hintText: localizations.searchHear).copyWith(
                icon: const Icon(Icons.search),
              ),
              inputFormatters: [LengthLimitingTextInputFormatter(60)], // 一旦60文字で制限
              enableInteractiveSelection: true, // コピペ可
              onChanged: (value) => ref.watch(mapServiceProvider).searchFacilities(value, languageCode),
            )
          : Row(
              children: [
                InkWell(
                  onTap: () {
                    if (!isPro) {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          fullscreenDialog: true,
                          builder: (context) {
                            return const PaymentDialog();
                          },
                        ),
                      );
                      return;
                    }
                    setState(() {
                      searchMode = true;
                    });
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
    );
  }
}
