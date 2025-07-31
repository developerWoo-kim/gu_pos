import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastUtil {
  static void showToast(BuildContext context, {
    required String content
  }) {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      title: Text(content),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }
}