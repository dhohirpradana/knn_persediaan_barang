import 'dart:convert';

class Persediaan {
  final int? id;
  final int idStok;
  final int qty;
  final int bulan;
  final int tahun;
  Persediaan({
    this.id,
    required this.idStok,
    required this.qty,
    required this.bulan,
    required this.tahun,
  });

  Persediaan copyWith({
    int? id,
    int? idStok,
    int? qty,
    int? bulan,
    int? tahun,
  }) {
    return Persediaan(
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

  factory Persediaan.fromMap(Map<String, dynamic> map) {
    return Persediaan(
      id: map['id']?.toInt(),
      idStok: map['idStok']?.toInt() ?? 0,
      qty: map['qty']?.toInt() ?? 0,
      bulan: map['bulan']?.toInt() ?? 0,
      tahun: map['tahun']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Persediaan.fromJson(String source) =>
      Persediaan.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Persediaan(id: $id, idStok: $idStok, qty: $qty, bulan: $bulan, tahun: $tahun)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Persediaan &&
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
