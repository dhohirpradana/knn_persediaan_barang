import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KController extends GetxController {
  int k = 3;

  void updateK(int value) {
    k = value;
    Get.snackbar(
      "SUCCESS",
      "Input Berhasil",
      icon: const Icon(CupertinoIcons.info, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    update();
  }
}
