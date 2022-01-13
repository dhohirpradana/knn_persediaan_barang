import 'package:get/get.dart';

class SelectedstokController extends GetxController {
  int? selectedStok;
  String? bulan;
  updateSelected(int? val, String? val1) {
    selectedStok = val;
    bulan = val1;
    update();
  }
}
