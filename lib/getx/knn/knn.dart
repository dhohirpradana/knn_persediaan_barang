import 'dart:math';
import 'package:get/get.dart';
import 'package:persediaan_barang/getx/penjualan_get.dart';
import 'package:persediaan_barang/models/penjualan.dart';
import '../k.dart';

class KNNController extends GetxController {
  final penjualanController = Get.put(PenjualanController());
  final kController = Get.put(KController());
  List filteredPenjualan = [];
  List targetList = [];
  List edList = [];
  int res = 0;
  int hasil = 0;

  init(int id, int bulanKedepan) async {
    targetList = [];
    hasil = 0;
    update();
    await Future.delayed(const Duration(milliseconds: 200));
    filteredPenjualan = penjualanController.penjualanList1
        .where((i) => i.idStok == id)
        .toList();
    if (filteredPenjualan.length > 9) {
      if (bulanKedepan > 1) {
        for (var i = 0; i < bulanKedepan; i++) {
          target(bulanKedepan);
        }
        hasil = res;
      } else {
        target(bulanKedepan);
        hasil = res;
      }
    } else {
      hasil = -1;
    }
    update();
  }

  target(int bulanKedepan) {
    for (var i = 5; i < filteredPenjualan.length; i++) {
      targetList.add(filteredPenjualan[i].qty);
    }
    ed(bulanKedepan);
  }

  ed(int bulanKedepan) {
    edList = [];
    for (var i = 0; i < filteredPenjualan.length - 6; i++) {
      final penjualan = filteredPenjualan;
      final ed = sqrt(pow(penjualan[i].qty - targetList[0], 2) +
          pow(penjualan[i + 1].qty - targetList[1], 2) +
          pow(penjualan[i + 2].qty - targetList[2], 2) +
          pow(penjualan[i + 3].qty - targetList[3], 2) +
          pow(penjualan[i + 4].qty - targetList[4], 2));
      edList.add({'index': i, 'ed': ed});
    }
    sort(bulanKedepan);
  }

  sort(int bulanKedepan) {
    edList.sort((a, b) => a['ed'].compareTo(b['ed']));
    result(bulanKedepan);
  }

  result(int bulanKedepan) {
    double sum = 0;
    final k =
        ((kController.k > edList.length - 2) ? edList.length : kController.k);
    for (var i = 0; i < k; i++) {
      sum = sum + targetList[edList[i]['index']];
    }
    res = (sum / k).floor();
    filteredPenjualan.add(Penjualan(
        idStok: 0, qty: (sum / kController.k).floor(), bulan: 0, tahun: 0));
  }

  resetHasil() {
    hasil = 0;
    update();
  }
}
