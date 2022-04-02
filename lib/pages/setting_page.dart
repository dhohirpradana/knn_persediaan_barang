// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persediaan_barang/databases/db_helper.dart';
import 'package:persediaan_barang/getx/selected_stok_get.dart';
import 'package:persediaan_barang/getx/stok_get.dart';
import 'add_stok_page.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final selectedStokController = Get.put(SelectedstokController());
  final _helper = DbHelper();

  final stokController = Get.put(StokController());

  @override
  Widget build(BuildContext context) {
    _helper.getDataStok();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CupertinoColors.systemOrange,
        title: const Text('SETTING'),
      ),
      backgroundColor: CupertinoColors.systemGrey5,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text('DATA VARIASI STOK',
                style: TextStyle(color: Colors.black54)),
            Expanded(
              child: GetBuilder<StokController>(
                builder: (controller) {
                  return ListView.builder(
                    itemCount: stokController.stokList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(stokController.stokList[index].kode
                                  .toString()),
                              Expanded(
                                  child: Column(children: [
                                Text(stokController.stokList[index].nama)
                              ])),
                              IconButton(
                                  tooltip: 'Hapus data stok',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Hapus?"),
                                          content: const Text(
                                              "Data penjualan yang berelasi juga akan TERHAPUS"),
                                          actions: [
                                            TextButton(
                                              child: const Text("Batal"),
                                              onPressed: () => Get.back(),
                                            ),
                                            TextButton(
                                              child: const Text("Hapus",
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              onPressed: () {
                                                Get.back();
                                                _helper.delete(
                                                    'penjualan',
                                                    'idStok',
                                                    stokController
                                                        .stokList[index].id!);
                                                _helper.delete(
                                                    'stok',
                                                    'id',
                                                    stokController
                                                        .stokList[index].id!);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.delete,
                                    color: CupertinoColors.destructiveRed,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orange[700]),
                  minimumSize: MaterialStateProperty.all(Size(Get.width, 40))),
              onPressed: () => Get.to(() => AddStokPage()),
              child: const Text('TAMBAH VARIASI STOK'),
            )
          ],
        ),
      ),
    );
  }
}
