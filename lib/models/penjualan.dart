import 'dart:convert';

class Penjualan {
  final int? id;
  final int idStok;
  final int qty;
  final int bulan;
  final int tahun;
  Penjualan({
    this.id,
    required this.idStok,
    required this.qty,
    required this.bulan,
    required this.tahun,
  });

  Penjualan copyWith({
    int? id,
    int? idStok,
    int? qty,
    int? bulan,
    int? tahun,
  }) {
    return Penjualan(
      id: id ?? this.id,
      idStok: idStok ?? this.idStok,
      qty: qty ?? this.qty,
      bulan: bulan ?? this.bulan,
      tahun: tahun ?? this.tahun,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idStok': idStok,
      'qty': qty,
      'bulan': bulan,
      'tahun': tahun,
    };
  }

  factory Penjualan.fromMap(Map<String, dynamic> map) {
    return Penjualan(
      id: map['id']?.toInt(),
      idStok: map['idStok']?.toInt() ?? 0,
      qty: map['qty']?.toInt() ?? 0,
      bulan: map['bulan']?.toInt() ?? 0,
      tahun: map['tahun']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Penjualan.fromJson(String source) =>
      Penjualan.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Penjualan(id: $id, idStok: $idStok, qty: $qty, bulan: $bulan, tahun: $tahun)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Penjualan &&
        other.id == id &&
        other.idStok == idStok &&
        other.qty == qty &&
        other.bulan == bulan &&
        other.tahun == tahun;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idStok.hashCode ^
        qty.hashCode ^
        bulan.hashCode ^
        tahun.hashCode;
  }
}
