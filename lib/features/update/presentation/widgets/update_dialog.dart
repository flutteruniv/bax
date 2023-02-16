import 'package:flutter/material.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        const SimpleDialogOption(
          child: Text('最新バージョンにアップデートしてください。'),
        ),
        SimpleDialogOption(
          child: ElevatedButton(
            child: const Text('アップデート'),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
