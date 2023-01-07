import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchTextFormField extends ConsumerWidget {
  const SearchTextFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(80),
        ),
      ),
      child: TextFormField(
        decoration: const InputDecoration.collapsed(hintText: 'ここで検索').copyWith(
          icon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
