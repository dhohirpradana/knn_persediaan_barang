import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persediaan_barang/databases/db_helper.dart';
import 'package:persediaan_barang/getx/penjualan_get.dart';
import 'package:persediaan_barang/pages/add_penjualan_page.dart';
import 'package:persediaan_barang/widgets/nama_bulan.dart';
import '../models/penjualan_select.dart';

class PenjualanPage extends StatefulWidget {
  const PenjualanPage({Key? key}) : super(key: key);

  @override
  State<PenjualanPage> createState() => _PenjualanPageState();
}

final penjualanController = Get.put(PenjualanController());

class _PenjualanPageState extends State<PenjualanPage> {
  bool isSearch = false;
  final _controller = TextEditingController();
  final DbHelper _helper = DbHelper();

  @override
  Widget build(BuildContext context) {
    _helper.getDataPenjualan();
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey5,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CupertinoColors.systemPink,
        title: (isSearch)
            ? Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    onChanged: (value) =>
                        penjualanController.searchPenjualan(value),
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    controller: _controller,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            setState(() {
                              isSearch = false;
                            });
                          },
                        ),
                        hintText: 'cari... ',
                        border: InputBorder.none),
                  ),
                ),
              )
            : const Text('PENJUALAN'),
        actions: [
          (isSearch == false)
              ? IconButton(
                  onPressed: () => setState(() => isSearch = true),
                  icon: const Icon(Icons.search))
              : const SizedBox()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'penjualanPage',
        backgroundColor: Colors.pink,
        onPressed: () => Get.to(() => const AddPenjualanPage()),
        child: const Icon(CupertinoIcons.add),
      ),
      body: GetBuilder<PenjualanController>(
        builder: (context) {
          List<PenjualanSelect> data = penjualanController.filteredPenjualan;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: (index == data.length - 1) ? 55 : 0),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data[index].tahun.toString()),
                        SizedBox(width: Get.width / 30),
                        Text(bulanNama(data[index].bulan)),
                        SizedBox(width: Get.width / 30),
                        Expanded(
                            child: Column(children: [Text(data[index].nama)])),
                        SizedBox(width: Get.width / 30),
                        Text(data[index].qty.toString()),
                        SizedBox(width: Get.width / 30),
                        IconButton(
                            tooltip: 'Hapus data penjualan',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Hapus?"),
                                    content: const Text(
                                        "Konfirmasi hapus data penjualan"),
                                    actions: [
                                      TextButton(
                                        child: const Text("Batal"),
                                        onPressed: () => Get.back(),
                                      ),
                                      TextButton(
                                        child: const Text("Hapus",
                                            style:
                                                TextStyle(color: Colors.red)),
                                        onPressed: () {
                                          Get.back();
                                          final DbHelper _helper = DbHelper();
                                          _helper.delete('penjualan', 'id',
                                              data[index].id);
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
