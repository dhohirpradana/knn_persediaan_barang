import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persediaan_barang/databases/db_helper.dart';
import 'package:persediaan_barang/getx/k.dart';
import 'package:persediaan_barang/getx/knn/knn.dart';
import 'package:persediaan_barang/getx/selected_stok_get.dart';
import 'package:persediaan_barang/getx/stok_get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final _controller = TextEditingController();
final _controllerK = TextEditingController();

class _HomePageState extends State<HomePage> {
  final kController = Get.put(KController());
  final knnControler = Get.put(KNNController());
  final stokController = Get.put(StokController());
  final selectedStokController = Get.put(SelectedstokController());

  int? _selectedStok;
  List dd = [];

  void updateK() {
    if (_controllerK.text != '') {
      kController.updateK((int.parse(_controllerK.text) > 0)
          ? int.parse(_controllerK.text)
          : 1);
      knnControler.resetHasil();
      // _controller.clear();
    }
  }

  final DbHelper _helper = DbHelper();

  @override
  Widget build(BuildContext context) {
    _helper.getDataPenjualan1();
    _helper.getDataStok();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CupertinoColors.activeBlue,
        title: const Text('HOME'),
      ),
      backgroundColor: CupertinoColors.systemGrey5,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GetBuilder<KController>(
              builder: (controller) => Text(
                kController.k.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: GetBuilder<KController>(
                  builder: (controller) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        autofocus: false,
                        controller: _controllerK,
                        onChanged: (_) => updateK(),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.number_square_fill,
                                color: Colors.grey),
                            hintText: 'Nilai K',
                            border: InputBorder.none),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: GetBuilder<StokController>(builder: (_) {
                  dd = stokController.stokList;
                  return DropdownButton(
                      hint: const Text('Pilih stok'),
                      underline: const SizedBox(),
                      isExpanded: true,
                      value: _selectedStok,
                      items: [
                        for (var item in dd)
                          DropdownMenuItem(
                              child: Text(item.nama), value: item.id)
                      ],
                      onChanged: (value) => setState(
                          () => _selectedStok = int.parse(value.toString())));
                }),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  controller: _controller,
                  decoration: const InputDecoration(
                      suffix: Text('bulan   '),
                      prefixIcon: Icon(CupertinoIcons.number_circle_fill,
                          color: Colors.deepPurple),
                      hintText: 'Prediksi untuk (bulan) kedepan',
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 10),
            GetBuilder<KNNController>(
              builder: (context) {
                if (knnControler.hasil == 0) {
                  return const SizedBox();
                } else if (knnControler.hasil == -1) {
                  final stokNama = stokController.stokList
                      .where((element) => element.id == _selectedStok)
                      .toList()[0]
                      .nama;

                  return Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: Get.width,
                      child: Center(
                        child: Text('Data persediaan $stokNama kurang dari 9',
                            style: TextStyle(
                                color: Colors.red[500],
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  );
                } else {
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: Get.width,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                                'PREDIKSI PENJUALAN ${_controller.text} BULAN KEDEPAN',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            Text(
                              knnControler.hasil.toString(),
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 3),
            GetBuilder<SelectedstokController>(builder: (_) {
              return ElevatedButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(Get.width, 40))),
                  onPressed: () {
                    if (_selectedStok != null &&
                        _controller.text != '' &&
                        _controller.text != '0') {
                      // if (selectedStokController.bulan != _controller.text ||
                      //     selectedStokController.selectedStok !=
                      //         _selectedStok) {
                      selectedStokController.updateSelected(
                          _selectedStok, _controller.text);
                      knnControler.init(
                          _selectedStok!, int.parse(_controller.text));
                      // }
                    } else {
                      knnControler.resetHasil();
                    }
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text('HITUNG'));
            }),
          ],
        ),
      ),
    );
  }
}
