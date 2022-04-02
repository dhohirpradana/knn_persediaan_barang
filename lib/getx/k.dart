import 'package:get/get.dart';

class KController extends GetxController {
  int k = 3;

  void updateK(int value) {
    k = value;
    update();
  }
}
