import 'package:flutter/material.dart';
import 'package:get/get.dart';

void mySnackBar({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    icon: const Icon(
      Icons.error,
      color: Colors.white,
      size: 30,
    ),
    margin: const EdgeInsets.all(10), 
    duration: const Duration(seconds: 3), 
  );
}
