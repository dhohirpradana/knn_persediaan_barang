import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persediaan_barang/getx/penjualan_get.dart';
import 'package:persediaan_barang/getx/stok_get.dart';
import 'package:persediaan_barang/models/penjualan.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'queries/penjualan_query.dart';
import 'queries/stok_query.dart';
import 'package:path/path.dart' as path;

class DbHelper {
  //membuat method singleton
  static final DbHelper _dbHelper = DbHelper._singleton();

  factory DbHelper() {
    return _dbHelper;
  }

  DbHelper._singleton();
  //baris terakhir singleton

  final tables = [
    PenjualanQuery.createTabel,
    StokQuery.createTabel
  ]; // membuat daftar table yang akan dibuat

  Future<Database> openDB() async {
    final dbPath = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(path.join(dbPath, 'penjualan.db'),
        onCreate: (db, version) {
      for (var table in tables) {
        db.execute(table).then((value) {
          // print("berashil ");
        }).catchError((err) {
          // print("errornya ${err.toString()}");
        });
      }
      // print('Table Created');
    }, version: 1);
  }

  Future<int> getCount(String tabelname, String columnName, value) async {
    final db = openDB();
    var dbclient = await db;
    int? count = Sqflite.firstIntValue(await dbclient.rawQuery(
        "SELECT COUNT(*) FROM $tabelname WHERE $columnName = $value"));
    return count!;
  }

  delete(String tabel, String column, int value) {
    openDB().then((db) async {
      await db.delete(tabel, where: '$column=?', whereArgs: [value]);
      (tabel != 'penjualan')
          ? () {}
          : Get.snackbar(
              "SUCCESS",
              "Hapus Berhasil",
              icon: const Icon(CupertinoIcons.info, color: Colors.white),
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.black87,
              colorText: Colors.white,
            );
      if (tabel == 'stok') {
        getDataStok();
        getDataPenjualan();
      } else {
        getDataPenjualan();
      }
      Get.back();
    }).catchError((err) {
      Get.snackbar(
        "GAGAL",
        err,
        icon: const Icon(CupertinoIcons.info, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    });
  }

  insertPenjualan(Penjualan data) async {
    final db = openDB();
    var dbclient = await db;
    final idStok = data.idStok;
    final qty = data.qty;
    final bulan = data.bulan;
    final tahun = data.tahun;
    int? count = Sqflite.firstIntValue(await dbclient.rawQuery(
        "SELECT COUNT(*) FROM penjualan WHERE idStok = $idStok AND bulan = $bulan AND tahun = $tahun"));
    if (count == 0) {
      dbclient.insert('penjualan', data.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      Get.snackbar(
        "SUCCESS",
        "Input Berhasil",
        icon: const Icon(CupertinoIcons.info, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      dbclient.rawUpdate(
          "UPDATE penjualan SET qty = $qty WHERE idStok = $idStok AND bulan = $bulan AND tahun = $tahun");
      Get.snackbar(
        "SUCCESS",
        "Update Berhasil",
        icon: const Icon(CupertinoIcons.info, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
    getDataPenjualan();
  }

  insertStok(Map<String, dynamic> data) {
    openDB().then((db) {
      db.insert('stok', data, conflictAlgorithm: ConflictAlgorithm.replace);
      Get.snackbar(
        "SUCCESS",
        "Input Berhasil",
        icon: const Icon(CupertinoIcons.info, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }).catchError((err) {
      // print("error $err");
      Get.snackbar(
        "GAGAL",
        err,
        icon: const Icon(CupertinoIcons.info, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    });
  }

  void getDataStok() async {
    final stokController = Get.put(StokController());
    final db = await openDB();
    var result = await db.query('stok');
    stokController.updateStok(result.toList());
  }

  void getDataPenjualan1() async {
    final penjualanController = Get.put(PenjualanController());
    final db = await openDB();
    var result = await db.query('penjualan');
    penjualanController.updatePenjualan1(result.toList());
  }

  void getDataPenjualan() async {
    final penjualanController = Get.put(PenjualanController());
    final db = await openDB();
    var result = await db.rawQuery(
        'SELECT penjualan.id, penjualan.tahun, penjualan.bulan, stok.nama, penjualan.qty FROM penjualan INNER JOIN stok on stok.id=penjualan.idStok');
    penjualanController.updatePenjualan(result.toList());
  }
}
