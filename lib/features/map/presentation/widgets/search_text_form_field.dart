import 'package:bax/features/map/application/map_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchTextFormField extends ConsumerWidget {
  const SearchTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeLanguage = Localizations.localeOf(context).languageCode;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(80),
        ),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: const InputDecoration.collapsed(hintText: 'ここで検索').copyWith(
          icon: const Icon(Icons.search),
        ),
        inputFormatters: [LengthLimitingTextInputFormatter(60)], // 一旦60文字で制限
        enableInteractiveSelection: true, // コピペ可
        onChanged: (value) => ref.watch(mapServiceProvider).searchFacilities(value, localeLanguage),
      ),
    );
  }
}
