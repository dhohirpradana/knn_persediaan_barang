class StokQuery {
  static const String tabelName = "stok";
  static const String createTabel =
      " CREATE TABLE IF NOT EXISTS $tabelName ( id INTEGER PRIMARY KEY AUTOINCREMENT, kode INTEGER, nama TEXT ) ";
  static const String select = "select * from $tabelName";
}
