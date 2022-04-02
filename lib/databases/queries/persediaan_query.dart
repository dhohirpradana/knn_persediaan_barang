class PersediaanQuery {
  static const String tabelName = "persediaan";
  static const String createTabel =
      " CREATE TABLE IF NOT EXISTS $tabelName ( id INTEGER PRIMARY KEY AUTOINCREMENT, idStok INTEGER, qty INTEGER, bulan INTEGER, tahun INTEGER ) ";
  static const String select = "select * from $tabelName";
}
