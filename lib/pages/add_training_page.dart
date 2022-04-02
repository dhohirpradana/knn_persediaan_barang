import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persediaan_barang/databases/db_helper.dart';
import 'package:persediaan_barang/getx/knn/knn.dart';
import 'package:persediaan_barang/getx/stok_get.dart';
import 'package:persediaan_barang/models/persediaan.dart';

class AddTrainingPage extends StatefulWidget {
  const AddTrainingPage({Key? key}) : super(key: key);

  @override
  State<AddTrainingPage> createState() => _AddTrainingPageState();
}

class _AddTrainingPageState extends State<AddTrainingPage> {
  final knnControler = Get.put(KNNController());
  final _jumlahController = TextEditingController();
  final _tahunController = TextEditingController();
  int? _selectedStok;
  int? _selectedBulan;
  final DbHelper _helper = DbHelper();
  final stokController = Get.put(StokController());

  @override
  void initState() {
    super.initState();
    _helper.getDataStok();
  }

  void insert() {
    if (_selectedStok != null && _selectedBulan != null) {
      _helper.insertPersediaan(Persediaan(
          bulan: _selectedBulan!,
          idStok: _selectedStok!,
          tahun: int.parse(_tahunController.text),
          qty: int.parse(_jumlahController.text)));
      _helper.getDataPersediaan();
      knnControler.resetHasil();
      setState(() {
        _jumlahController.clear();
        _selectedBulan = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CupertinoColors.activeGreen,
        title: const Text('TAMBAH DATA'),
      ),
      backgroundColor: CupertinoColors.systemGrey5,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: GetBuilder<StokController>(
                    builder: (controller) => DropdownButton(
                        hint: const Text('Pilih stok'),
                        underline: const SizedBox(),
                        isExpanded: true,
                        value: _selectedStok,
                        items: [
                          for (var item in stokController.stokList)
                            DropdownMenuItem(
                                child: Text(item.nama), value: item.id)
                        ],
                        onChanged: (value) => setState(() =>
                            _selectedStok = int.parse(value.toString())))),
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
                  textInputAction: TextInputAction.next,
                  controller: _tahunController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.number_square_fill,
                          color: Colors.purple),
                      hintText: 'Tahun',
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: DropdownButton(
                        underline: const SizedBox(),
                        isExpanded: true,
                        value: _selectedBulan,
                        items: const [
                          DropdownMenuItem(child: Text("Januari"), value: 1),
                          DropdownMenuItem(child: Text("Februari"), value: 2),
                          DropdownMenuItem(child: Text("Maret"), value: 3),
                          DropdownMenuItem(child: Text("April"), value: 4),
                          DropdownMenuItem(child: Text("Mei"), value: 5),
                          DropdownMenuItem(child: Text("Juni"), value: 6),
                          DropdownMenuItem(child: Text("Juli"), value: 7),
                          DropdownMenuItem(child: Text("Agustus"), value: 8),
                          DropdownMenuItem(child: Text("September"), value: 9),
                          DropdownMenuItem(child: Text("Oktober"), value: 10),
                          DropdownMenuItem(child: Text("November"), value: 11),
                          DropdownMenuItem(child: Text("Desember"), value: 12)
                        ],
                        onChanged: (value) => setState(
                            () => _selectedBulan = int.parse(value.toString())),
                        hint: const Text("Pilih bulan")))),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: _jumlahController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.number_circle_fill,
                          color: Colors.blue),
                      hintText: 'Jumlah',
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    minimumSize:
                        MaterialStateProperty.all(Size(Get.width, 40))),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  await Future.delayed(const Duration(milliseconds: 300));
                  insert();
                },
                child: const Text('SIMPAN'))
          ],
        ),
      ),
    );
  }
}
