import 'package:get/state_manager.dart';
import 'package:persediaan_barang/models/persediaan.dart';
import 'package:persediaan_barang/models/persediaan_select.dart';
import 'package:persediaan_barang/widgets/nama_bulan.dart';

class PersediaanController extends GetxController {
  List<Persediaan> persediaanList1 = [];
  List<PersediaanSelect> persediaanList = [];
  List<PersediaanSelect> filteredPersediaan = [];

  void updatePersediaan1(List data) {
    persediaanList1 = [];
    for (var item in data) {
      persediaanList1.add(Persediaan.fromMap(item));
    }
    persediaanList.sort(
        (a, b) => (a.tahun * 12 + a.bulan).compareTo((b.tahun * 12 + b.bulan)));
    filteredPersediaan = persediaanList;
    update();
  }

  void updatePersediaan(List data) {
    persediaanList = [];
    filteredPersediaan = [];
    for (var item in data) {
      persediaanList.add(PersediaanSelect.fromMap(item));
    }
    persediaanList.sort(
        (a, b) => (a.tahun * 12 + a.bulan).compareTo((b.tahun * 12 + b.bulan)));
    filteredPersediaan = persediaanList;
    update();
  }

  void searchPersediaan(String text) {
    if (text.isNotEmpty) {
      filteredPersediaan = persediaanList
          .where((i) =>
                  bulanNama(i.bulan)
                      .toLowerCase()
                      .contains(text.toLowerCase()) ||
                  i.tahun.toString() == text
              // ||
              // i.nama.toLowerCase().contains(text.toLowerCase())
              )
          .toList();
    } else {
      filteredPersediaan = persediaanList;
    }
    update();
  }
}
