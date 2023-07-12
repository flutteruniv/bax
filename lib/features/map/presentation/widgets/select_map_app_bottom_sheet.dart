import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppMapType {
  apple,
  google,
}

class SelectMapAppBottomSheet extends ConsumerStatefulWidget {
  const SelectMapAppBottomSheet({super.key});

  static Future<AppMapType?> show(BuildContext context) async {
    return showModalBottomSheet<AppMapType>(
      context: context,
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return const SelectMapAppBottomSheet();
      },
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectMapAppBottomSheetState();
}

class _SelectMapAppBottomSheetState extends ConsumerState<SelectMapAppBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(AppMapType.apple),
                  child: const Card(
                    child: Center(child: Text('Apple Map で開く')),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(AppMapType.google),
                  child: const Card(
                    child: Center(child: Text('Google Map で開く')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
