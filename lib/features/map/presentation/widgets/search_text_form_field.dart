import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../payment/presentation/payment_dialog.dart';
import '../../../payment/repository/payment_repository.dart';
import '../../application/map_service.dart';

class SearchTextFormField extends ConsumerStatefulWidget {
  const SearchTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchTextFormFieldState();
}

class _SearchTextFormFieldState extends ConsumerState<SearchTextFormField> {
  bool searchMode = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus == false) {
        setState(() {
          searchMode = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localeLanguage = Localizations.localeOf(context).languageCode;
    final isPro = ref.watch(isProProvider);
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
              decoration: const InputDecoration.collapsed(hintText: 'ここで検索').copyWith(
                icon: const Icon(Icons.search),
              ),
              inputFormatters: [LengthLimitingTextInputFormatter(60)], // 一旦60文字で制限
              enableInteractiveSelection: true, // コピペ可
              onChanged: (value) => ref.watch(mapServiceProvider).searchFacilities(value, localeLanguage),
            )
          : Row(
              children: [
                InkWell(
                  onTap: () {
                    if (!isPro) {
                      // TODO(kenta-wakasa): 課金ダイアログを表示

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
