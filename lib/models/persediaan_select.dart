import 'dart:convert';

class PersediaanSelect {
  final int id;
  final int tahun;
  final int bulan;
  final String nama;
  final int qty;
  PersediaanSelect({
    required this.id,
    required this.tahun,
    required this.bulan,
    required this.nama,
    required this.qty,
  });

  PersediaanSelect copyWith({
    int? id,
    int? tahun,
    int? bulan,
    String? nama,
    int? qty,
  }) {
    return PersediaanSelect(
      id: id ?? this.id,
      tahun: tahun ?? this.tahun,
      bulan: bulan ?? this.bulan,
      nama: nama ?? this.nama,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tahun': tahun,
      'bulan': bulan,
      'nama': nama,
      'qty': qty,
    };
  }

  factory PersediaanSelect.fromMap(Map<String, dynamic> map) {
    return PersediaanSelect(
      id: map['id']?.toInt() ?? 0,
      tahun: map['tahun']?.toInt() ?? 0,
      bulan: map['bulan']?.toInt() ?? 0,
      nama: map['nama'] ?? '',
      qty: map['qty']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersediaanSelect.fromJson(String source) =>
      PersediaanSelect.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PenjualanSelect(id: $id, tahun: $tahun, bulan: $bulan, nama: $nama, qty: $qty)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersediaanSelect &&
        other.id == id &&
        other.tahun == tahun &&
        other.bulan == bulan &&
        other.nama == nama &&
        other.qty == qty;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tahun.hashCode ^
        bulan.hashCode ^
        nama.hashCode ^
        qty.hashCode;
  }
}
