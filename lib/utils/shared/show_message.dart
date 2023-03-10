import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum MessageType {
  error,
  success,
}

void showMessage(
  BuildContext context, {
  required String message,
  required MessageType messageType,
}) {
  SchedulerBinding.instance.addPostFrameCallback(
    (timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor:
              messageType == MessageType.error ? Colors.red : Colors.green,
        ),
      );
    },
  );
}
