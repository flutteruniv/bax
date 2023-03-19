import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/bax.dart';

class BaxRewordDialog extends ConsumerStatefulWidget {
  const BaxRewordDialog({
    super.key,
    required this.bax,
  });
  final Bax bax;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaxRewordDialogState();
}

class _BaxRewordDialogState extends ConsumerState<BaxRewordDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('獲得したBAX'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...widget.bax.baxReasons.map((e) => Text(e.text)),
                // const SizedBox(
                //   width: 16,
                // ),
                //           Container(
                //             alignment: Alignment.bottomCenter,
                //             width: 240,
                //             height: 40,
                //             child: Padding(
                //               padding: const EdgeInsets.only(bottom: 16),
                //               child: ElevatedButton.icon(
                //                 icon: const Icon(Icons.share),
                //                 // onPressed: share,
                //                 onPressed: (){},
                //                 label: const Text('結果をシェア'),
                //               ),
                //             ),
                //           ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
