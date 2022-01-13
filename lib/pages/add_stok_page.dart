import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persediaan_barang/databases/db_helper.dart';
import 'package:persediaan_barang/models/stok.dart';

class AddStokPage extends StatelessWidget {
  AddStokPage({Key? key}) : super(key: key);

  final _kodeStokController = TextEditingController();
  final _namaStokController = TextEditingController();
  final DbHelper _helper = DbHelper();
  final _key = GlobalKey<FormState>();

  Future<void> createStok() async {
    if (_key.currentState!.validate()) {
      await _helper
          .getCount('stok', 'kode', _kodeStokController.text)
          .then((value) {
        if (value == 0) {
          _helper.insertStok(Stok(
                  kode: int.parse(_kodeStokController.text),
                  nama: _namaStokController.text)
              .toMap());
          _kodeStokController.clear();
          _helper.getDataStok();
        } else {
          final kode = _kodeStokController.text;
          Get.snackbar(
            "GAGAL",
            'Data dengan kode $kode sudah ada',
            icon: const Icon(CupertinoIcons.info, color: Colors.white),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CupertinoColors.systemOrange,
        title: const Text('TAMBAH VARIASI BARANG'),
      ),
      backgroundColor: CupertinoColors.systemGrey5,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextFormField(
                    validator: (value) {
                      if (value == '') {
                        return '    tidak boleh kosong';
                      } else if (value == '0') {
                        return '    tidak boleh nol';
                      } else if (value!.length < 4) {
                        return '    minimal 4 angka';
                      } else if (value[0] == '0') {
                        return '    tidak boleh berawalah nol';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: _kodeStokController,
                    decoration: const InputDecoration(
                        prefixIcon:
                            Icon(CupertinoIcons.barcode, color: Colors.grey),
                        hintText: 'Kode Stok',
                        border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextFormField(
                    validator: (value) {
                      if (value == '') {
                        return '    tidak boleh kosong';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: _namaStokController,
                    decoration: const InputDecoration(
                        prefixIcon:
                            Icon(CupertinoIcons.tickets, color: Colors.orange),
                        hintText: 'Nama Stok',
                        border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange[700]),
                    minimumSize:
                        MaterialStateProperty.all(Size(Get.width, 40))),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  createStok();
                },
                child: const Text('TAMBAH'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
