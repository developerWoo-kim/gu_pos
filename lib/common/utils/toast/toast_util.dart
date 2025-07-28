import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastUtil {
  static void showToast(BuildContext context) {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      title: Text('Hello, world!'),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}