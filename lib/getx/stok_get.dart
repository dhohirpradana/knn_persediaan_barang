import 'package:get/state_manager.dart';
import 'package:persediaan_barang/models/stok.dart';

class StokController extends GetxController {
  List<Stok> stokList = [];

  void updateStok(List data) {
    stokList = [];
    for (var item in data) {
      stokList.add(Stok.fromMap(item));
    }
    update();
  }
}
