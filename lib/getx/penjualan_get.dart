import 'package:get/state_manager.dart';
import 'package:persediaan_barang/models/penjualan.dart';
import 'package:persediaan_barang/models/penjualan_select.dart';
import 'package:persediaan_barang/widgets/nama_bulan.dart';

class PenjualanController extends GetxController {
  List<Penjualan> penjualanList1 = [];
  List<PenjualanSelect> penjualanList = [];
  List<PenjualanSelect> filteredPenjualan = [];

  void updatePenjualan1(List data) {
    penjualanList1 = [];
    for (var item in data) {
      penjualanList1.add(Penjualan.fromMap(item));
    }
    penjualanList.sort(
        (a, b) => (a.tahun * 12 + a.bulan).compareTo((b.tahun * 12 + b.bulan)));
    filteredPenjualan = penjualanList;
    update();
  }

  void updatePenjualan(List data) {
    penjualanList = [];
    filteredPenjualan = [];
    for (var item in data) {
      penjualanList.add(PenjualanSelect.fromMap(item));
    }
    penjualanList.sort(
        (a, b) => (a.tahun * 12 + a.bulan).compareTo((b.tahun * 12 + b.bulan)));
    filteredPenjualan = penjualanList;
    update();
  }

  void searchPenjualan(String text) {
    if (text.isNotEmpty) {
      filteredPenjualan = penjualanList
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
      filteredPenjualan = penjualanList;
    }
    update();
  }
}
