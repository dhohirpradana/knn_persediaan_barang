import 'dart:convert';

class Stok {
  final int? id;
  final int kode;
  final String nama;
  Stok({
    this.id,
    required this.kode,
    required this.nama,
  });

  Stok copyWith({
    int? id,
    int? kode,
    String? nama,
  }) {
    return Stok(
      id: id ?? this.id,
      kode: kode ?? this.kode,
      nama: nama ?? this.nama,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kode': kode,
      'nama': nama,
    };
  }

  factory Stok.fromMap(Map<String, dynamic> map) {
    return Stok(
      id: map['id']?.toInt(),
      kode: map['kode']?.toInt() ?? 0,
      nama: map['nama'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Stok.fromJson(String source) => Stok.fromMap(json.decode(source));

  @override
  String toString() => 'Stok(id: $id, kode: $kode, nama: $nama)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Stok &&
        other.id == id &&
        other.kode == kode &&
        other.nama == nama;
  }

  @override
  int get hashCode => id.hashCode ^ kode.hashCode ^ nama.hashCode;
}
