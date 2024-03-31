import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future displayDialog({
  required BuildContext context,
  required String message,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text('Gemini Says'),
        content: Text(message),
        actions: [
          CupertinoButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Okay'),
          ),
        ],
      );
    },
  );
}
